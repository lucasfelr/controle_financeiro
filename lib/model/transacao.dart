enum TipoTransacao { deposito, gasto }

class Transacao {
  final String id;
  final String contaId;
  final TipoTransacao tipo;
  final double valor;
  final String tag;
  final DateTime data;
  
  // Controle de parcelas
  final bool isParcelada;
  final int parcelaAtual;
  final int totalParcelas;

  Transacao({
    required this.id,
    required this.contaId,
    required this.tipo,
    required this.valor,
    required this.tag,
    required this.data,
    this.isParcelada = false,
    this.parcelaAtual = 1,
    this.totalParcelas = 1,
  });
}