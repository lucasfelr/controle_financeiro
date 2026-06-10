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
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.edit, color: Colors.blue),
                                title: const Text('Editar Conta'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _abrirDialogEditarConta(context, conta, context.read<FinanceProvider>());
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.delete, color: Colors.red),
                                title: const Text('Deletar Conta'),
                                onTap: () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Deletar Conta'),
                                      content: Text('Apagar a conta "${conta.nome}" e seu histórico?'),
                                      actions: [
                                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                                        TextButton(
                                          onPressed: () {
                                            context.read<FinanceProvider>().deletarConta(conta.id);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Aquele mesmo Modal de criar conta, agora no lugar certo
          showDialog(
            context: context,
            builder: (context) {
              final nomeController = TextEditingController();
              final saldoController = TextEditingController();
              final limiteController = TextEditingController();
              bool isCredito = false;
              return StatefulBuilder(
                builder: (context, setState) {
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
                        // Novo switch para definir se a conta é de crédito ou débito
                        SwitchListTile(
                          title: const Text('É cartão de crédito?'),
                          value: isCredito,
                          onChanged: (val) {
                            setState(() {
                              isCredito = val;
                              // Limpa o limite se desabilitar o crédito
                              if (!isCredito) {
                                limiteController.clear();
                              }
                            });
                          },
                        ),
                        // Campo de limite só aparece se for crédito
                        if (isCredito)
                          TextField(
                            controller: limiteController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(hintText: 'Limite do Cartão (R\$)'),
                          ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      // ADICIONADO: ElevatedButton que estava faltando envolvendo o onPressed
                      ElevatedButton(
                        onPressed: () {
                          if (nomeController.text.isNotEmpty) {
                            final saldo = double.tryParse(saldoController.text) ?? 0.0;
                            final limite = double.tryParse(limiteController.text);
                            // Passando os argumentos corretamente para adicionarConta
                            context.read<FinanceProvider>().adicionarConta(
                              nomeController.text,
                              grupo.id,
                              saldo,
                              isCredito, // Argumento posicional para isCredito
                              isCredito ? limite : null, // Argumento posicional para limiteCredito, null se não for crédito
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Salvar'),
                      ),
                    ],
                  );
                }
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

void _abrirDialogEditarConta(BuildContext context, Conta conta, FinanceProvider provider) {
  final nomeController = TextEditingController(text: conta.nome);
  final saldoController = TextEditingController(text: conta.saldoInicial.toString());

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Editar Conta'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome da Conta')),
          const SizedBox(height: 8),
          TextField(
            controller: saldoController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Saldo Inicial (R\$)'),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: () {
            if (nomeController.text.isNotEmpty) {
              final novoSaldo = double.tryParse(saldoController.text) ?? conta.saldoInicial;
              provider.editarConta(conta.id, nomeController.text, novoSaldo);
              Navigator.pop(context);
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    ),
  );
}