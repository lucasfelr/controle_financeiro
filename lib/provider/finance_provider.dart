// provider/finance_provider.dart
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../model/banco_de_dados.dart';
import '../service/transacao_service.dart'; // O serviço de parcelas criado anteriormente

class FinanceProvider extends ChangeNotifier {
  late Isar isar;
  
  List<Grupo> _grupos = [];
  List<Conta> _contas = [];
  List<Transacao> _transacoes = [];
  List<RelatorioSalvo> _relatoriosSalvos = [];
  
  final TransacaoService _transacaoService = TransacaoService();

  List<Grupo> get grupos => _grupos;
  List<Conta> get contas => _contas;
  List<Transacao> get transacoes => _transacoes;
  List<RelatorioSalvo> get relatoriosSalvos => _relatoriosSalvos;

  // Inicializa o banco de dados
  Future<void> initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [GrupoSchema, ContaSchema, TransacaoSchema, RelatorioSalvoSchema],
      directory: dir.path,
    );
    await carregarDados();
  }

  // Busca todos os dados salvos
  Future<void> carregarDados() async {
    _grupos = await isar.grupos.where().findAll();
    _contas = await isar.contas.where().findAll();
    _transacoes = await isar.transacaos.where().findAll();
    _relatoriosSalvos = await isar.relatorioSalvos.where().findAll();
    notifyListeners();
  }

  // Salva uma transação simples no banco de dados Isar
  Future<void> adicionarTransacaoSimples({
    required int contaId,
    required String nome,
    required TipoTransacao tipo,
    required double valor,
    required String tag,
  }) async {
    final novaTransacao = Transacao()
      ..contaId = contaId
      ..nome = nome
      ..tipo = tipo
      ..valor = valor
      ..tag = tag
      ..data = DateTime.now()
      ..isParcelada = false
      ..parcelaAtual = 1
      ..totalParcelas = 1;

    await isar.writeTxn(() async {
      await isar.transacaos.put(novaTransacao);
    });
    await carregarDados();
  }

  // Salva uma nova conta vinculada a um grupo
  Future<void> adicionarConta(String nome, int grupoId, double saldoInicial) async {
    final novaConta = Conta()
      ..nome = nome
      ..grupoId = grupoId
      ..saldoInicial = saldoInicial;

    await isar.writeTxn(() async {
      await isar.contas.put(novaConta);
    });
    await carregarDados();
  }

  // Salva um novo grupo no banco
  Future<void> adicionarGrupo(String nome) async {
    final novoGrupo = Grupo()..nome = nome;
    
    await isar.writeTxn(() async {
      await isar.grupos.put(novoGrupo);
    });
    await carregarDados(); // Recarrega as listas e avisa a UI
  }

  // Salva transações parceladas no banco
  Future<void> adicionarTransacaoParcelada({
    required int contaId, // Agora é int
    required String nome,
    required String tag,
    required DateTime dataInicial,
    required int quantidadeParcelas,
    double? valorTotal,
    double? valorParcela,
  }) async {
    final parcelas = _transacaoService.gerarTransacoesParceladas(
      contaId: contaId,
      nome: nome,
      tag: tag,
      dataInicial: dataInicial,
      quantidadeParcelas: quantidadeParcelas,
      valorTotal: valorTotal,
      valorParcela: valorParcela,
    );

    await isar.writeTxn(() async {
      await isar.transacaos.putAll(parcelas); // Salva a lista inteira de uma vez
    });
    await carregarDados();
  }

  // Lógica de cálculo de saldos (Adaptada para IDs inteiros)
  double calcularSaldoConta(int contaId) {
    final conta = _contas.cast<Conta?>().firstWhere((c) => c?.id == contaId, orElse: () => null);
    if (conta == null) return 0.0;

    double saldo = conta.saldoInicial;
    for (var t in _transacoes.where((t) => t.contaId == contaId)) {
      saldo += (t.tipo == TipoTransacao.deposito) ? t.valor : -t.valor;
    }
    return saldo;
  }

  double calcularSaldoGrupo(int grupoId) {
    double total = 0.0;
    final contasDoGrupo = _contas.where((c) => c.grupoId == grupoId);
    for (var conta in contasDoGrupo) {
      total += calcularSaldoConta(conta.id);
    }
    return total;
  }

  double get saldoGeral {
    return _contas.fold(0.0, (soma, conta) => soma + calcularSaldoConta(conta.id));
  }

  // Deleta uma transação específica
  Future<void> deletarTransacao(int id) async {
    await isar.writeTxn(() async {
      await isar.transacaos.delete(id);
    });
    await carregarDados();
  }

  // Deleta uma conta e todas as transações vinculadas a ela
  Future<void> deletarConta(int id) async {
    await isar.writeTxn(() async {
      // 1. Apaga as transações da conta
      await isar.transacaos.filter().contaIdEqualTo(id).deleteAll();
      // 2. Apaga a conta em si
      await isar.contas.delete(id);
    });
    await carregarDados();
  }

  // Deleta um grupo, todas as suas contas e todas as transações dessas contas
  Future<void> deletarGrupo(int id) async {
    await isar.writeTxn(() async {
      // 1. Busca todas as contas que pertencem a este grupo
      final contasDoGrupo = await isar.contas.filter().grupoIdEqualTo(id).findAll();
      
      // 2. Para cada conta, apaga suas transações e depois a própria conta
      for (var conta in contasDoGrupo) {
        await isar.transacaos.filter().contaIdEqualTo(conta.id).deleteAll();
        await isar.contas.delete(conta.id);
      }
      
      // 3. Por fim, apaga o grupo
      await isar.grupos.delete(id);
    });
    await carregarDados();
  }

  // Salva um retrato do relatório no banco
  Future<void> salvarRelatorioGerado({
    required String nome,
    DateTime? dataInicial,
    DateTime? dataFinal,
    required double gastoTotal,
    required Map<String, double> gastosPorTag,
  }) async {
    final novoRelatorio = RelatorioSalvo()
      ..nome = nome
      ..dataInicial = dataInicial
      ..dataFinal = dataFinal
      ..gastoTotal = gastoTotal
      ..tagsNomes = gastosPorTag.keys.toList()
      ..tagsValores = gastosPorTag.values.toList()
      ..dataCriacao = DateTime.now();

    await isar.writeTxn(() async {
      await isar.relatorioSalvos.put(novoRelatorio);
    });
    await carregarDados();
  }

  // Deleta o relatório salvo
  Future<void> deletarRelatorioSalvo(int id) async {
    await isar.writeTxn(() async {
      await isar.relatorioSalvos.delete(id);
    });
    await carregarDados();
  }
}