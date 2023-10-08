import 'package:calculadora_imc_sqlite/pages/calculadora_imc_page.dart';
import 'package:calculadora_imc_sqlite/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: CalculadoraImcPage(),
      ),
    );
  }
}
