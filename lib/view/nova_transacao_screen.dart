import 'package:flutter/material.dart';
import '../model/banco_de_dados.dart';
import '../provider/finance_provider.dart';

class NovaTransacaoScreen extends StatefulWidget {
  final FinanceProvider financeProvider;

  const NovaTransacaoScreen({Key? key, required this.financeProvider}) : super(key: key);

  @override
  State<NovaTransacaoScreen> createState() => _NovaTransacaoScreenState();
}

class _NovaTransacaoScreenState extends State<NovaTransacaoScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controladores de texto
  final _nomeController = TextEditingController(); // AQUI ESTÁ O CONTROLADOR FALTANDO!
  final _valorController = TextEditingController();
  final _tagController = TextEditingController();
  final _parcelasController = TextEditingController(text: '2');

  TipoTransacao _tipoSelecionado = TipoTransacao.gasto;
  int? _contaSelecionadaId;
  
  bool _isParcelado = false;
  bool _definirPorValorTotal = true; 

  @override
  void dispose() {
    // É importante limpar a memória quando a tela é fechada
    _nomeController.dispose();
    _valorController.dispose();
    _tagController.dispose();
    _parcelasController.dispose();
    super.dispose();
  }

  void _salvarFormulario() {
    if (!_formKey.currentState!.validate()) return;

    final nome = _nomeController.text;
    final valor = double.parse(_valorController.text);
    final tag = _tagController.text;
    final contaId = _contaSelecionadaId!;

    if (_tipoSelecionado == TipoTransacao.gasto && _isParcelado) {
      final qtdParcelas = int.parse(_parcelasController.text);
      
      widget.financeProvider.adicionarTransacaoParcelada(
        contaId: contaId,
        nome: nome,
        tag: tag,
        dataInicial: DateTime.now(),
        quantidadeParcelas: qtdParcelas,
        valorTotal: _definirPorValorTotal ? valor : null,
        valorParcela: !_definirPorValorTotal ? valor : null,
      );
    } else {
      widget.financeProvider.adicionarTransacaoSimples(
        contaId: contaId,
        nome: nome,
        tipo: _tipoSelecionado,
        valor: valor,
        tag: tag,
      );
    }

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transação adicionada com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contas = widget.financeProvider.contas;

    return Scaffold(
      appBar: AppBar(title: const Text('Nova Transação')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Gasto')),
                      selected: _tipoSelecionado == TipoTransacao.gasto,
                      onSelected: (val) => setState(() => _tipoSelecionado = TipoTransacao.gasto),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Depósito')),
                      selected: _tipoSelecionado == TipoTransacao.deposito,
                      onSelected: (val) => setState(() => _tipoSelecionado = TipoTransacao.deposito),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<int>(
                value: _contaSelecionadaId,
                decoration: const InputDecoration(labelText: 'Selecione a Conta', border: OutlineInputBorder()),
                items: contas.map((conta) {
                  return DropdownMenuItem<int>(value: conta.id, child: Text(conta.nome));
                }).toList(),
                onChanged: (id) => setState(() => _contaSelecionadaId = id),
                validator: (value) => value == null ? 'Selecione uma conta' : null,
              ),
              const SizedBox(height: 16),

              // Novo campo na tela para digitar o Nome/Descrição
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Descrição (Ex: Mercado, Uber)', border: OutlineInputBorder()),
                validator: (value) => (value == null || value.isEmpty) ? 'Insira um nome' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _valorController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: _isParcelado && !_definirPorValorTotal ? 'Valor da Parcela (R\$)' : 'Valor (R\$)',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => (value == null || double.tryParse(value) == null) ? 'Insira um valor válido' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _tagController,
                decoration: const InputDecoration(labelText: 'Tag (ex: Alimentação, Lazer)', border: OutlineInputBorder()),
                validator: (value) => (value == null || value.isEmpty) ? 'Insira uma tag' : null,
              ),
              const SizedBox(height: 16),

              if (_tipoSelecionado == TipoTransacao.gasto) ...[
                CheckboxListTile(
                  title: const Text('Esta compra é parcelada?'),
                  value: _isParcelado,
                  onChanged: (val) => setState(() => _isParcelado = val ?? false),
                ),
                if (_isParcelado) ...[
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _parcelasController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Nº de Parcelas', border: OutlineInputBorder()),
                          validator: (value) => (value == null || int.tryParse(value) == null) ? 'Inválido' : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RadioListTile<bool>(
                    title: const Text('O valor digitado é o Total da compra'),
                    value: true,
                    groupValue: _definirPorValorTotal,
                    onChanged: (val) => setState(() => _definirPorValorTotal = val!),
                  ),
                  RadioListTile<bool>(
                    title: const Text('O valor digitado é de apenas uma Parcela'),
                    value: false,
                    groupValue: _definirPorValorTotal,
                    onChanged: (val) => setState(() => _definirPorValorTotal = val!),
                  ),
                ],
              ],
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _salvarFormulario,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Confirmar Transação', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}