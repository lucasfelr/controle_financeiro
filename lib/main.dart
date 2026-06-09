import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/finance_provider.dart';
import 'view/dashboard_screen.dart'; // Ajuste o caminho conforme seu projeto

void main() async {
  // Garante que os bindings do Flutter estão prontos antes de chamar código assíncrono
  WidgetsFlutterBinding.ensureInitialized();
  
  final financeProvider = FinanceProvider();
  await financeProvider.initDB(); // Inicializa o Isar e carrega os dados

  runApp(
    ChangeNotifierProvider.value(
      value: financeProvider,
      child: const MeuAppFinanceiro(),
    ),
  );
}

class MeuAppFinanceiro extends StatelessWidget {
  const MeuAppFinanceiro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Finanças',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}