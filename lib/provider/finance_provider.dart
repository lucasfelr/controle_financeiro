// provider/finance_provider.dart
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../model/banco_de_dados.dart';
import '../service/transacao_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Importação adicionada

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
    DateTime? data,
  }) async {
    final novaTransacao = Transacao()
      ..contaId = contaId
      ..nome = nome
      ..tipo = tipo
      ..valor = valor
      ..tag = tag
      ..data = data ?? DateTime.now()
      ..isParcelada = false
      ..parcelaAtual = 1
      ..totalParcelas = 1;

    await isar.writeTxn(() async {
      await isar.transacaos.put(novaTransacao);
    });
    await carregarDados();
  }

  // Salva uma nova conta vinculada a um grupo
  Future<void> adicionarConta(String nome, int grupoId, double saldoInicial, bool isCredito, double? limiteCredito) async {
    final novaConta = Conta()
      ..nome = nome
      ..grupoId = grupoId
      ..saldoInicial = saldoInicial
      ..isCredito = isCredito
      ..limiteCredito = limiteCredito;

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

    // Se for crédito, o "saldo" é o valor que já foi gasto no cartão,
    // que é a soma de todos os gastos daquela conta.
    if (conta.isCredito) {
      return _transacoes
          .where((t) => t.contaId == contaId && t.tipo == TipoTransacao.gasto)
          .fold(0.0, (soma, t) => soma + t.valor);
    }

    // Se for débito, o saldo é Saldo Inicial + Depósitos - Gastos
    double total = conta.saldoInicial;
    for (var t in _transacoes.where((t) => t.contaId == contaId)) {
      total += (t.tipo == TipoTransacao.deposito) ? t.valor : -t.valor;
    }
    return total;
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

  // Novo método para deletar múltiplas transações
  Future<void> deletarMultiplasTransacoes(List<int> ids) async {
    await isar.writeTxn(() async {
      await isar.transacaos.deleteAll(ids);
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

  // --- MÉTODOS DE EDIÇÃO ---

  Future<void> editarGrupo(int id, String novoNome) async {
    await isar.writeTxn(() async {
      final grupo = await isar.grupos.get(id);
      if (grupo != null) {
        grupo.nome = novoNome;
        await isar.grupos.put(grupo);
      }
    });
    await carregarDados();
  }

  Future<void> editarConta(int id, String novoNome, double novoSaldo) async {
    await isar.writeTxn(() async {
      final conta = await isar.contas.get(id);
      if (conta != null) {
        conta.nome = novoNome;
        conta.saldoInicial = novoSaldo;
        await isar.contas.put(conta);
      }
    });
    await carregarDados();
  }

  Future<void> editarTransacao(int id, String novoNome, double novoValor, String novaTag, DateTime novaData) async {
    await isar.writeTxn(() async {
      final transacao = await isar.transacaos.get(id);
      if (transacao != null) {
        transacao.nome = novoNome;
        transacao.valor = novoValor;
        transacao.tag = novaTag;
        transacao.data = novaData; // <-- Atualizando a data no banco
        await isar.transacaos.put(transacao);
      }
    });
    await carregarDados();
  }

  Future<void> processarExtratoComIA(String caminhoImagem, int contaId) async {
    final apiKey = dotenv.env['AI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("API Key não configurada!");
    }
    final model = GenerativeModel(model: 'gemini-3.1-flash-lite', apiKey: apiKey); // Versão ajustada para uma disponível
    try {
      print('--- 1. INICIANDO LEITURA DA IA ---');
      final bytesImagem = await File(caminhoImagem).readAsBytes();
      final imagemParte = DataPart('image/jpeg', bytesImagem);
      final prompt = TextPart(
        "Analise esta imagem de extrato bancário. Retorne ESTRITAMENTE um array JSON contendo as transações. "
        "Cada objeto deve ter: 'nome' (string), 'valor' (double total), 'tipo' (string 'gasto' ou 'deposito'), "
        "'tag' (string curta categorizando), 'data' (string YYYY-MM-DD), 'isParcelada' (boolean), "
        "e 'totalParcelas' (int, 1 se não for parcelada). "
        "NÃO responda with crases, blocos de código ou qualquer outro texto. Apenas o array JSON puro."
      );

      final response = await model.generateContent([
        Content.multi([prompt, imagemParte])
      ]);

      print('--- 2. RESPOSTA BRUTA DA IA ---');
      print(response.text);

      final textoPuro = (response.text ?? '[]')
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      print('--- 3. TEXTO LIMPO PARA O PARSER ---');
      print(textoPuro);

      final List<dynamic> transacoes = jsonDecode(textoPuro);
      print('--- 4. TOTAL DE TRANSAÇÕES ENCONTRADAS: ${transacoes.length} ---');

      for (var t in transacoes) {
        DateTime dataParsed = DateTime.now();
        if (t['data'] != null) {
          try {
            dataParsed = DateTime.parse(t['data']);
          } catch (e) {
             print('Erro ao converter a data: ${t['data']}');
          }
        }

        bool isParcelada = (t['isParcelada'] ?? false) == true;
        int totalParcelas = (t['totalParcelas'] ?? 1) as int;
        if (totalParcelas < 1) totalParcelas = 1; // Trava de segurança

        double valorTotal = (t['valor'] ?? 0.0).toDouble();
        double valorParcela = isParcelada ? (valorTotal / totalParcelas) : valorTotal;
        print('Salvando no banco: ${t['nome']} (Parcelado: $isParcelada, Valor da parcela: $valorParcela)');

        for (int i = 0; i < totalParcelas; i++) {
          DateTime dataParcela = DateTime(
            dataParsed.year,
            dataParsed.month + i,
            dataParsed.day,
          );

          await adicionarTransacaoSimples(
            contaId: contaId,
            nome: isParcelada ? "${t['nome']} (${i + 1}/$totalParcelas)" : (t['nome'] ?? 'Lido por IA'),
            tipo: t['tipo'] == 'deposito' ? TipoTransacao.deposito : TipoTransacao.gasto,
            valor: valorParcela,
            tag: t['tag'] ?? 'IA',
            data: dataParcela,
          );
        }
      }
      print('--- 5. PROCESSO CONCLUÍDO ---');
      
    } catch (e) {
      print('--- ERRO FATAL NA IA ---');
      print(e);
      rethrow; // Joga o error de volta para a tela mostrar a barra vermelha
    }
  }
}