import '../model/banco_de_dados.dart';

class RelatorioController {
  final List<Transacao> todasTransacoes;

  RelatorioController(this.todasTransacoes);

  double get gastoTotal {
    return todasTransacoes
        .where((t) => t.tipo == TipoTransacao.gasto)
        .fold(0.0, (soma, t) => soma + t.valor);
  }

  double gastoPorTag(String tag) {
    return todasTransacoes
        .where((t) => t.tipo == TipoTransacao.gasto && t.tag.toLowerCase() == tag.toLowerCase())
        .fold(0.0, (soma, t) => soma + t.valor);
  }

  Map<String, double> get gastosAgrupadosPorTag {
    Map<String, double> mapa = {};
    for (var t in todasTransacoes.where((t) => t.tipo == TipoTransacao.gasto)) {
      if (mapa.containsKey(t.tag)) {
        mapa[t.tag] = mapa[t.tag]! + t.valor;
      } else {
        mapa[t.tag] = t.valor;
      }
    }
    return mapa;
  }
}