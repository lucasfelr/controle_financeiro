import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/finance_provider.dart';
import 'provider/theme_provider.dart';
import 'view/dashboard_screen.dart';
void main() async {
  // Garante que os bindings do Flutter estão prontos antes de chamar código assíncrono
  WidgetsFlutterBinding.ensureInitialized();
  
  final financeProvider = FinanceProvider();
  await financeProvider.initDB(); // Inicializa o Isar e carrega os dados

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: financeProvider),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MeuAppFinanceiro(),
    ),
  );
}

class MeuAppFinanceiro extends StatelessWidget {
  const MeuAppFinanceiro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Financeiro',
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark, // A mágica acontece aqui
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}