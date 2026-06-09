// lib/view/relatorio_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/finance_provider.dart';
import '../model/banco_de_dados.dart';
import 'relatorios_salvos_screen.dart';

class RelatorioScreen extends StatefulWidget {
  const RelatorioScreen({Key? key}) : super(key: key);

  @override
  State<RelatorioScreen> createState() => _RelatorioScreenState();
}

class _RelatorioScreenState extends State<RelatorioScreen> {
  DateTime? _dataInicial;
  DateTime? _dataFinal;

  // Função para abrir o calendário e escolher a data
  Future<void> _selecionarData(BuildContext context, bool isInicial) async {
    final DateTime? selecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selecionada != null) {
      setState(() {
        if (isInicial) {
          _dataInicial = selecionada;
        } else {
          _dataFinal = selecionada;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();

    // 1. Filtra as transações baseadas nas datas escolhidas
    List<Transacao> gastosFiltrados = provider.transacoes.where((t) {
      if (t.tipo != TipoTransacao.gasto) return false; // Pega só os gastos
      
      // Zera as horas para a comparação de dias ser exata
      DateTime dataTx = DateTime(t.data.year, t.data.month, t.data.day);
      
      if (_dataInicial != null) {
        DateTime inicio = DateTime(_dataInicial!.year, _dataInicial!.month, _dataInicial!.day);
        if (dataTx.isBefore(inicio)) return false;
      }
      
      if (_dataFinal != null) {
        DateTime fim = DateTime(_dataFinal!.year, _dataFinal!.month, _dataFinal!.day);
        if (dataTx.isAfter(fim)) return false;
      }
      
      return true;
    }).toList();

    // 2. Calcula o gasto total do período
    double gastoTotal = gastosFiltrados.fold(0.0, (soma, t) => soma + t.valor);

    // 3. Agrupa os gastos por Tag
    Map<String, double> gastosPorTag = {};
    for (var t in gastosFiltrados) {
      // Se a tag estiver vazia, agrupa como "Sem Tag"
      String tagReal = t.tag.trim().isNotEmpty ? t.tag : 'Sem Tag';
      gastosPorTag[tagReal] = (gastosPorTag[tagReal] ?? 0.0) + t.valor;
    }

    // Transforma o mapa em uma lista e ordena da tag com maior gasto para a menor
    var listaTagsOrdenada = gastosPorTag.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
        centerTitle: true,
        actions: [
          // Botão 1: Ver a lista de relatórios salvos
          IconButton(
            icon: const Icon(Icons.folder_special),
            tooltip: 'Ver Salvos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RelatoriosSalvosScreen()),
              );
            },
          ),
          // Botão 2: Salvar o relatório que está na tela agora
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Salvar Relatório',
            onPressed: () {
              if (gastosPorTag.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Não há dados para salvar.')),
                );
                return;
              }

              // Pede um nome para o relatório
              final nomeController = TextEditingController();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Salvar Relatório'),
                  content: TextField(
                    controller: nomeController,
                    decoration: const InputDecoration(hintText: 'Ex: Viagem, Janeiro...'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (nomeController.text.isNotEmpty) {
                          provider.salvarRelatorioGerado(
                            nome: nomeController.text,
                            dataInicial: _dataInicial,
                            dataFinal: _dataFinal,
                            gastoTotal: gastoTotal,
                            gastosPorTag: gastosPorTag,
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Relatório salvo!')),
                          );
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Seletor de Datas
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).primaryColorLight.withOpacity(0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _selecionarData(context, true),
                    icon: const Icon(Icons.calendar_today, size: 18),
                    label: Text(_dataInicial == null 
                        ? 'Data Inicial' 
                        : '${_dataInicial!.day}/${_dataInicial!.month}/${_dataInicial!.year}'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _selecionarData(context, false),
                    icon: const Icon(Icons.calendar_today, size: 18),
                    label: Text(_dataFinal == null 
                        ? 'Data Final' 
                        : '${_dataFinal!.day}/${_dataFinal!.month}/${_dataFinal!.year}'),
                  ),
                ),
              ],
            ),
          ),

          // Card do Gasto Total
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Theme.of(context).primaryColor,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text('Gasto Total no Período', style: TextStyle(color: Colors.white70, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${gastoTotal.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Lista de Gastos por Tag
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Gastos por Tag', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
          
          Expanded(
            child: listaTagsOrdenada.isEmpty
                ? const Center(child: Text('Nenhum gasto neste período.'))
                : ListView.builder(
                    itemCount: listaTagsOrdenada.length,
                    itemBuilder: (context, index) {
                      final item = listaTagsOrdenada[index];
                      // Calcula a porcentagem que essa tag representa do total
                      final porcentagem = (item.value / gastoTotal) * 100;

                      return ListTile(
                        leading: const Icon(Icons.label_outline),
                        title: Text(item.key, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('${porcentagem.toStringAsFixed(1)}% do total'),
                        trailing: Text(
                          'R\$ ${item.value.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}