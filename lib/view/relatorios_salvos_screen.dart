// lib/view/relatorios_salvos_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/finance_provider.dart';

class RelatoriosSalvosScreen extends StatelessWidget {
  const RelatoriosSalvosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();
    // Ordena do mais recente salvo para o mais antigo
    final relatorios = provider.relatoriosSalvos.toList()
      ..sort((a, b) => b.dataCriacao.compareTo(a.dataCriacao));

    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios Salvos')),
      body: relatorios.isEmpty
          ? const Center(child: Text('Nenhum relatório salvo.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: relatorios.length,
              itemBuilder: (context, index) {
                final r = relatorios[index];
                
                // Formata o texto do período
                String periodo = 'Todo o período';
                if (r.dataInicial != null && r.dataFinal != null) {
                  periodo = '${r.dataInicial!.day}/${r.dataInicial!.month} até ${r.dataFinal!.day}/${r.dataFinal!.month}';
                }

                return Card(
                  child: ExpansionTile(
                    leading: const Icon(Icons.pie_chart),
                    title: Text(r.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Gasto: R\$ ${r.gastoTotal.toStringAsFixed(2)}\nPeríodo: $periodo'),
                    children: [
                      const Divider(),
                      // Gera a listinha das tags dentro do Card expansível
                      ...List.generate(r.tagsNomes.length, (i) {
                        return ListTile(
                          dense: true,
                          title: Text(r.tagsNomes[i]),
                          trailing: Text('R\$ ${r.tagsValores[i].toStringAsFixed(2)}'),
                        );
                      }),
                      const Divider(),
                      TextButton.icon(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text('Deletar Relatório', style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          // Exclui com um clique
                          provider.deletarRelatorioSalvo(r.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}