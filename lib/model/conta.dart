class Conta {
  final String id;
  final String grupoId; // Permite o agrupamento dinâmico
  final String nome;
  final double saldoInicial;

  Conta({
    required this.id,
    required this.grupoId,
    required this.nome,
    this.saldoInicial = 0.0,
  });
}