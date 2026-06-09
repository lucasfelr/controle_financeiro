import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/finance_provider.dart';
import '../model/banco_de_dados.dart';

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
                          _mostrarDialogExclusao(
                            context: context,
                            titulo: 'Deletar Transação',
                            mensagem: 'Tem certeza que deseja apagar a transação "${t.nome}"?',
                            onConfirmar: () => provider.deletarTransacao(t.id),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
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