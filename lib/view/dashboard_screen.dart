import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/finance_provider.dart';
import 'nova_transacao_screen.dart'; // Importação que faltava!
import 'detalhes_grupo_screen.dart';
import 'relatorio_screen.dart';
import '../provider/theme_provider.dart';
import '../model/banco_de_dados.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Escuta as mudanças do banco de dados em tempo real
    final provider = context.watch<FinanceProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visão Geral'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                tooltip: 'Alternar Tema',
                onPressed: () {
                  // Inverte o estado atual
                  themeProvider.toggleTheme(!themeProvider.isDarkMode);
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.pie_chart),
            tooltip: 'Relatórios',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RelatorioScreen()),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Resumo Geral
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Saldo Geral',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${provider.saldoGeral.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Título da Seção
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Seus Grupos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // Modal para criar um novo grupo
                      showDialog(
                        context: context,
                        builder: (context) {
                          final controller = TextEditingController();
                          return AlertDialog(
                            title: const Text('Novo Grupo'),
                            content: TextField(
                              controller: controller,
                              decoration: const InputDecoration(hintText: 'Ex: Bancos, Cartões...'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    provider.adicionarGrupo(controller.text);
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Salvar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            
            // Lista Dinâmica de Grupos e Saldos
            Expanded(
              child: provider.grupos.isEmpty
                  ? const Center(child: Text('Nenhum grupo criado ainda.'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: provider.grupos.length,
                      itemBuilder: (context, index) {
                        final grupo = provider.grupos[index];
                        final saldoDoGrupo = provider.calcularSaldoGrupo(grupo.id);

                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColorLight,
                              child: const Icon(Icons.folder_outlined, color: Colors.black87),
                            ),
                            title: Text(
                              grupo.nome,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            subtitle: Text('${provider.contas.where((c) => c.grupoId == grupo.id).length} contas vinculadas'),
                            trailing: Text(
                              'R\$ ${saldoDoGrupo.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: saldoDoGrupo >= 0 ? Colors.green[700] : Colors.red[700],
                              ),
                            ),
                            onTap: () {
                              // Agora ao invés de criar conta, ele entra no grupo!
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetalhesGrupoScreen(grupo: grupo),
                                ),
                              );
                            },
                            onLongPress: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.edit, color: Colors.blue),
                                        title: const Text('Editar Grupo'),
                                        onTap: () {
                                          Navigator.pop(context); // Fecha o menu
                                          _abrirDialogEditarGrupo(context, grupo, provider);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.delete, color: Colors.red),
                                        title: const Text('Deletar Grupo'),
                                        onTap: () {
                                          Navigator.pop(context); // Fecha o menu
                                          // ... AQUI VOCÊ COLA AQUELE showDialog DE EXCLUSÃO QUE JÁ EXISTIA
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Deletar Grupo'),
                                              content: Text('Tem certeza que deseja apagar o grupo "${grupo.nome}"?'),
                                              actions: [
                                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                                                TextButton(
                                                  onPressed: () {
                                                    provider.deletarGrupo(grupo.id);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Deletar', style: TextStyle(color: Colors.red)),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navega para a tela de nova transação passando o provider
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NovaTransacaoScreen(financeProvider: provider),
            ),
          );
        },
        label: const Text('Nova Transação'),
        icon: const Icon(Icons.add_card),
      ),
    );
  }
}

void _abrirDialogEditarGrupo(BuildContext context, Grupo grupo, FinanceProvider provider) {
  final nomeController = TextEditingController(text: grupo.nome);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Editar Grupo'),
      content: TextField(
        controller: nomeController,
        decoration: const InputDecoration(labelText: 'Nome do Grupo'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: () {
            if (nomeController.text.isNotEmpty) {
              provider.editarGrupo(grupo.id, nomeController.text);
              Navigator.pop(context);
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    ),
  );
}