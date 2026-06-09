// lib/service/transacao_service.dart
import '../model/banco_de_dados.dart';

class TransacaoService {
  List<Transacao> gerarTransacoesParceladas({
    required int contaId,
    required String nome, // <-- NOVO PARÂMETRO
    required String tag,
    required DateTime dataInicial,
    required int quantidadeParcelas,
    double? valorTotal,
    double? valorParcela,
  }) {
    List<Transacao> parcelas = [];
    double valorFinalParcela = 0.0;

    if (valorTotal != null && valorTotal > 0) {
      valorFinalParcela = valorTotal / quantidadeParcelas;
    } else if (valorParcela != null && valorParcela > 0) {
      valorFinalParcela = valorParcela;
    } else {
      throw Exception("Informe o valor total ou o valor da parcela.");
    }

    for (int i = 0; i < quantidadeParcelas; i++) {
      DateTime dataParcela = DateTime(dataInicial.year, dataInicial.month + i, dataInicial.day);

      final parcela = Transacao()
        ..contaId = contaId
        ..nome = nome // <-- SALVANDO O NOME
        ..tipo = TipoTransacao.gasto
        ..valor = valorFinalParcela
        ..tag = tag
        ..data = dataParcela
        ..isParcelada = true
        ..parcelaAtual = i + 1
        ..totalParcelas = quantidadeParcelas;

      parcelas.add(parcela);
    }

    return parcelas;
  }
}