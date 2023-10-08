import 'package:calculadora_imc_sqlite/repository/calculadora_imc.dart';
import 'package:calculadora_imc_sqlite/service/altura_service.dart';
import 'package:calculadora_imc_sqlite/service/calculadora_imc_service.dart';
import '../utils/calculadora_imc_classificacao.dart';
import 'calculadora_imc_repository.dart';

class CalculadoraImcSqLiteRepository implements CalculadoraImcRepository {
  final CalculadoraImcService imcService = CalculadoraImcService();
  final AlturaService alturaService = AlturaService();

  @override
  Future<void> addAltura(CalculadoraImc imc) async {
    await alturaService.add(imc.altura!);
  }

  @override
  Future<void> addIMC(CalculadoraImc imc) async {
    final altura = await getAltura();
    final classificacao =
        CalculadoraImcClassificacao.classificacao(imc.peso!, altura);

    await imcService.add(imc.peso!, classificacao);
  }

  @override
  Future<double> getAltura() async {
    return await alturaService.getOne();
  }

  @override
  Future<List<CalculadoraImc>> getIMCs() async {
    final response = await imcService.getAll();
    final imcs = response.map((imc) => CalculadoraImc.fromJson(imc)).toList();
    return imcs;
  }

  @override
  Future<void> removeIMC(CalculadoraImc imc) async {
    await imcService.delete(imc.id!);
  }
}
