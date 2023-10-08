import 'package:calculadora_imc_sqlite/repository/calculadora_imc.dart';

abstract interface class CalculadoraImcRepository {
  Future<void> addAltura(CalculadoraImc imc);
  Future<double> getAltura();
  Future<void> addIMC(CalculadoraImc imc);
  Future<void> removeIMC(CalculadoraImc imc);
  Future<List<CalculadoraImc>> getIMCs();
}
