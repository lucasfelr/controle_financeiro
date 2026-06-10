import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/finance_provider.dart';
import '../model/banco_de_dados.dart';
import 'nova_transacao_screen.dart';
import 'package:image_picker/image_picker.dart';

class DetalhesContaScreen extends StatefulWidget {
  final Conta conta;

  const DetalhesContaScreen({Key? key, required this.conta}) : super(key: key);

  @override
  State<DetalhesContaScreen> createState() => _DetalhesContaScreenState();
}

class _DetalhesContaScreenState extends State<DetalhesContaScreen> {
  // Variáveis de estado para a seleção
  bool _isSelectionMode = false;
  final Set<int> _selectedTransactionIds = {}; // Usar Set para IDs únicos

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();
    
    // Busca as transações desta conta e ordena da mais recente para a mais antiga
    final transacoesDaConta = provider.transacoes
        .where((t) => t.contaId == widget.conta.id) 
        .toList()
      ..sort((a, b) => b.data.compareTo(a.data));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.conta.nome), 
        actions: [
          IconButton(
            icon: const Icon(Icons.document_scanner, color: Colors.deepPurple),
            tooltip: 'Importar extrato com IA',
            onPressed: () {
              _processarImagem(context, provider, widget.conta.id);
            },
          ),
          if (_isSelectionMode) // Só mostra o botão se o modo de seleção estiver ativo
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () {
                _mostrarDialogExclusao(
                  context: context,
                  titulo: 'Deletar Transações',
                  mensagem: 'Tem certeza que deseja apagar ${_selectedTransactionIds.length} transações selecionadas?',
                  onConfirmar: () async {
                    await provider.deletarMultiplasTransacoes(_selectedTransactionIds.toList());
                    setState(() {
                      _isSelectionMode = false;
                      _selectedTransactionIds.clear();
                    });
                  },
                );
              },
            ),
          if (_isSelectionMode) // Botão para cancelar seleção
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  _isSelectionMode = false;
                  _selectedTransactionIds.clear();
                });
              },
            )
          else // Botão para ativar modo de seleção
            IconButton(
              icon: const Icon(Icons.checklist),
              onPressed: () {
                setState(() {
                  _isSelectionMode = true;
                });
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Header com o Saldo Atual (Atualizado para Contas de Crédito)
          Container(
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.deepPurple[900]?.withOpacity(0.2)
                : Theme.of(context).primaryColorLight,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  // Modificado para exibir 'Limite' em contas de crédito
                  widget.conta.isCredito ? 'Limite' : 'Saldo Atual',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  // A lógica do valor calculado permanece 100% idêntica à de débito
                  'R\$ ${provider.calcularSaldoConta(widget.conta.id).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
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
                        leading: _isSelectionMode // Mostra checkbox no modo de seleção
                            ? Checkbox(
                                value: _selectedTransactionIds.contains(t.id),
                                onChanged: (bool? selected) {
                                  setState(() {
                                    if (selected == true) {
                                      _selectedTransactionIds.add(t.id);
                                    } else {
                                      _selectedTransactionIds.remove(t.id);
                                    }
                                  });
                                },
                              )
                            : CircleAvatar(
                                backgroundColor: isGasto ? Colors.red[100] : Colors.green[100],
                                child: Icon(
                                  isGasto ? Icons.remove_circle_outline : Icons.add_circle_outline,
                                  color: isGasto ? Colors.red : Colors.green,
                                ),
                              ),
                        title: Text(
                          t.nome.isNotEmpty ? t.nome : 'Transação sem nome',
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        subtitle: Text(
                          '${t.data.day.toString().padLeft(2, '0')}/${t.data.month.toString().padLeft(2, '0')}/${t.data.year}$infoParcela\nTag: ${t.tag}',
                        ),
                        isThreeLine: true,
                        trailing: Text(
                          '${isGasto ? "-" : "+"} R\$ ${t.valor.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: isGasto ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onLongPress: () {
                          // Se o modo de seleção estiver ativo, o long press seleciona/desseleciona
                          if (_isSelectionMode) {
                            setState(() {
                              if (_selectedTransactionIds.contains(t.id)) {
                                _selectedTransactionIds.remove(t.id);
                              } else {
                                _selectedTransactionIds.add(t.id);
                              }
                            });
                          } else { // Caso contrário, mostra o menu normal
                            _showTransactionOptionsMenu(context, t, provider);
                          }
                        },
                        // Se o modo de seleção estiver ativo, o onTap também seleciona/desseleciona
                        onTap: () {
                          if (_isSelectionMode) {
                            setState(() {
                              if (_selectedTransactionIds.contains(t.id)) {
                                _selectedTransactionIds.remove(t.id);
                              } else {
                                _selectedTransactionIds.add(t.id);
                              }
                            });
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar Transação',
        child: const Icon(Icons.add),
        onPressed: () {
          // Oculta o modo de seleção ao adicionar nova transação
          setState(() {
            _isSelectionMode = false;
            _selectedTransactionIds.clear();
          });
          // Simplificado: apenas abre a tela de nova transação diretamente
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NovaTransacaoScreen(
                financeProvider: provider,
                contaId: widget.conta.id,
              ),
            ),
          );
        },
      ),
    );
  }

  // Novo método para exibir opções de transação (editar/deletar)
  void _showTransactionOptionsMenu(BuildContext context, Transacao t, FinanceProvider provider) {
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
                _mostrarDialogExclusao(
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

  DateTime dataSelecionada = t.data;

  showDialog(
    context: context,
    builder: (context) {
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
                          dataSelecionada = novaData;
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

Future<void> _processarImagem(BuildContext context, FinanceProvider provider, int contaId) async {
  final picker = ImagePicker();
  final xfile = await picker.pickImage(source: ImageSource.gallery);

  if (xfile == null) return;

  if (!context.mounted) return;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('A IA está lendo o comprovante...'),
            ],
          ),
        ),
      ),
    ),
  );

  try {
    await provider.processarExtratoComIA(xfile.path, contaId);

    if (!context.mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transações importadas com sucesso!'), backgroundColor: Colors.green),
    );
  } catch (e) {
    if (!context.mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao processar imagem: $e'), backgroundColor: Colors.red),
    );
  }
}