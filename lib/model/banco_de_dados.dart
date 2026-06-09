import 'package:isar/isar.dart';

part 'banco_de_dados.g.dart'; // Arquivo gerado automaticamente pelo build_runner

@collection
class Grupo {
  Id id = Isar.autoIncrement;
  late String nome;
}

@collection
class Conta {
  Id id = Isar.autoIncrement;
  late int grupoId; // Referência ao ID do Grupo
  late String nome;
  late double saldoInicial;
}

enum TipoTransacao { deposito, gasto }

@collection
class Transacao {
  Id id = Isar.autoIncrement;
  late int contaId; // Referência ao ID da Conta
  
  @enumerated
  late TipoTransacao tipo;
  
  late String nome;
  late double valor;
  late String tag;
  late DateTime data;
  
  late bool isParcelada;
  late int parcelaAtual;
  late int totalParcelas;
}

@collection
class RelatorioSalvo {
  Id id = Isar.autoIncrement;
  
  late String nome; // Ex: "Viagem pra Praia" ou "Gastos de Março"
  DateTime? dataInicial;
  DateTime? dataFinal;
  late double gastoTotal;
  
  // O Isar permite salvar listas simples, o que é perfeito para as nossas tags
  late List<String> tagsNomes;
  late List<double> tagsValores;
  
  late DateTime dataCriacao;
}