// lib/view/detalhes_grupo_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/finance_provider.dart';
import '../model/banco_de_dados.dart';
import 'detalhes_conta_screen.dart';

class DetalhesGrupoScreen extends StatelessWidget {
  final Grupo grupo;

  const DetalhesGrupoScreen({Key? key, required this.grupo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Escuta o provider para atualizar a lista de contas automaticamente
    final provider = context.watch<FinanceProvider>();
    
    // Filtra apenas as contas que pertencem a este grupo
    final contasDoGrupo = provider.contas.where((c) => c.grupoId == grupo.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(grupo.nome),
        centerTitle: true,
      ),
      body: contasDoGrupo.isEmpty
          ? const Center(child: Text('Nenhuma conta neste grupo.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: contasDoGrupo.length,
              itemBuilder: (context, index) {
                final conta = contasDoGrupo[index];
                final saldoConta = provider.calcularSaldoConta(conta.id);

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.account_balance_wallet),
                    title: Text(conta.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Saldo: R\$ ${saldoConta.toStringAsFixed(2)}',
                      style: TextStyle(color: saldoConta >= 0 ? Colors.green : Colors.red),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Vai para a tela de transações da conta!
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhesContaScreen(conta: conta),
                        ),
                      );
                    },
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Deletar Conta'),
                          content: Text('Tem certeza que deseja apagar a conta "${conta.nome}"? Isso apagará todo o histórico de transações dela.'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                            TextButton(
                              onPressed: () {
                                provider.deletarConta(conta.id);
                                Navigator.pop(context);
                              },
                              child: const Text('Deletar', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Aquele mesmo Modal de criar conta, agora no lugar certo
          showDialog(
            context: context,
            builder: (context) {
              final nomeController = TextEditingController();
              final saldoController = TextEditingController();
              return AlertDialog(
                title: Text('Nova Conta em ${grupo.nome}'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nomeController,
                      decoration: const InputDecoration(hintText: 'Nome da Conta'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: saldoController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(hintText: 'Saldo Inicial (R\$)'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (nomeController.text.isNotEmpty) {
                        final saldo = double.tryParse(saldoController.text) ?? 0.0;
                        // Como você não está em um Widget com context fixo (dialog),
                        // acessamos o provider via read() para evitar erros
                        context.read<FinanceProvider>().adicionarConta(nomeController.text, grupo.id, saldo);
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
        label: const Text('Nova Conta'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}