import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/finance_provider.dart';
import '../model/banco_de_dados.dart';
import 'nova_transacao_screen.dart';

class DetalhesContaScreen extends StatelessWidget {
  final Conta conta;

  const DetalhesContaScreen({Key? key, required this.conta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();
    
    // Busca as transações desta conta e ordena da mais recente para a mais antiga
    final transacoesDaConta = provider.transacoes
        .where((t) => t.contaId == conta.id)
        .toList()
      ..sort((a, b) => b.data.compareTo(a.data));

    return Scaffold(
      appBar: AppBar(
        title: Text(conta.nome),
      ),
      body: Column(
        children: [
          // Header com o Saldo Atual
          Container(
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).primaryColorLight,
            width: double.infinity,
            child: Text(
              'Saldo Atual: R\$ ${provider.calcularSaldoConta(conta.id).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          
          // Lista de Transações
          Expanded(
            child: transacoesDaConta.isEmpty
                ? const Center(child: Text('Nenhuma transação registrada.'))
                : ListView.builder(
                    itemCount: transacoesDaConta.length,
                    itemBuilder: (context, index) {
                      final t = transacoesDaConta[index];
                      final isGasto = t.tipo == TipoTransacao.gasto;

                      // Texto extra para mostrar se é parcela (Ex: 1/3)
                      String infoParcela = t.isParcelada 
                          ? ' (Parcela ${t.parcelaAtual}/${t.totalParcelas})' 
                          : '';

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isGasto ? Colors.red[100] : Colors.green[100],
                          child: Icon(
                            isGasto ? Icons.remove_circle_outline : Icons.add_circle_outline,
                            color: isGasto ? Colors.red : Colors.green,
                          ),
                        ),
                        
                        // --- AQUI ESTÁ A CORREÇÃO ---
                        title: Text(
                          t.nome.isNotEmpty ? t.nome : 'Transação sem nome', 
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        // A tag agora fica no subtítulo, junto com a data
                        subtitle: Text(
                          '${t.data.day}/${t.data.month}/${t.data.year}$infoParcela\nTag: ${t.tag}',
                        ),
                        isThreeLine: true, // Garante que o texto de 3 linhas caiba perfeitamente
                        // ----------------------------
                        
                        trailing: Text(
                          '${isGasto ? "-" : "+"} R\$ ${t.valor.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: isGasto ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.edit, color: Colors.blue),
                                    title: const Text('Editar Transação'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _abrirDialogEditarTransacao(context, t, provider);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.delete, color: Colors.red),
                                    title: const Text('Deletar Transação'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _mostrarDialogExclusao( // Aquela função que você já tinha colocado
                                        context: context,
                                        titulo: 'Deletar Transação',
                                        mensagem: 'Tem certeza que deseja apagar "${t.nome}"?',
                                        onConfirmar: () => provider.deletarTransacao(t.id),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar Transação nesta conta',
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NovaTransacaoScreen(
                financeProvider: provider,
                contaId: conta.id, // <-- Passando o ID da conta atual
              ),
            ),
          );
        },
      ),
    );
  }
}

void _mostrarDialogExclusao({
  required BuildContext context,
  required String titulo,
  required String mensagem,
  required VoidCallback onConfirmar,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(titulo),
      content: Text(mensagem),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            onConfirmar();
            Navigator.pop(context);
          },
          child: const Text('Deletar', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

void _abrirDialogEditarTransacao(BuildContext context, Transacao t, FinanceProvider provider) {
  final nomeController = TextEditingController(text: t.nome);
  final valorController = TextEditingController(text: t.valor.toString());
  final tagController = TextEditingController(text: t.tag);
  
  // Inicia com a data atual da transação salva no banco
  DateTime dataSelecionada = t.data;

  showDialog(
    context: context,
    builder: (context) {
      // O StatefulBuilder permite atualizar variáveis dentro de um Dialog aberto
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text('Editar Transação'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Descrição')),
                  const SizedBox(height: 8),
                  TextField(
                    controller: valorController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                  ),
                  const SizedBox(height: 8),
                  TextField(controller: tagController, decoration: const InputDecoration(labelText: 'Tag (ex: Lazer)')),
                  const SizedBox(height: 16),
                  
                  // Novo botão de editar a data
                  OutlinedButton.icon(
                    onPressed: () async {
                      final DateTime? novaData = await showDatePicker(
                        context: context,
                        initialDate: dataSelecionada,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (novaData != null) {
                        setStateDialog(() {
                          dataSelecionada = novaData; // Atualiza o texto do botão
                        });
                      }
                    },
                    icon: const Icon(Icons.calendar_today, size: 18),
                    label: Text('Data: ${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}'),
                    style: OutlinedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              ElevatedButton(
                onPressed: () {
                  if (nomeController.text.isNotEmpty && tagController.text.isNotEmpty) {
                    final novoValor = double.tryParse(valorController.text) ?? t.valor;
                    // Envia a data selecionada para o provider
                    provider.editarTransacao(t.id, nomeController.text, novoValor, tagController.text, dataSelecionada);
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
  );
}