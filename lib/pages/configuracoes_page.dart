import 'package:calculadora_imc_sqlite/repository/calculadora_imc.dart';
import 'package:calculadora_imc_sqlite/repository/calculadora_imc_repository.dart';
import 'package:calculadora_imc_sqlite/repository/calculadora_imc_sqlite_repository.dart';
import 'package:calculadora_imc_sqlite/shared/widgets/custom_text_form_field.dart';
import 'package:calculadora_imc_sqlite/shared/widgets/height_setting_item.dart';
import 'package:flutter/material.dart';
import '../../utils/form_field_validation.dart';
import '../../utils/methods.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  TextEditingController alturaController = TextEditingController();
  bool loading = false;
  bool isValid = true;
  String? messageValidation;
  double altura = 0.0;

  CalculadoraImcRepository repository = CalculadoraImcSqLiteRepository();

  @override
  void initState() {
    super.initState();
    _getAltura();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Configurações"),
      ),
      body: ListView(
        children: [
          if (loading) const LinearProgressIndicator(),
          HeightSettingItem(
            children: [
              const Text(
                "Informe a Altura em metros",
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                controller: alturaController,
                hintText: '${altura.toStringAsFixed(2)} m',
                suffixIcon: _AddAltura(
                  onPressed: _onAddAlturaPressed,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _getAltura() async {
    try {
      var response = await repository.getAltura();

      setState(() {
        alturaController.text = response.toString();
      });
    } catch (e) {
      if (mounted) {
        showErrorMessage(
            context, "Houve um erro ao tentar obter os dados no banco!");
      }
    }
  }

  _onAddAlturaPressed() async {
    _validateHeight();

    if (isValid) {
      _showLoadingProgress();

      await _addAltura();
      await _getAltura();

      clearTextField(alturaController);
      _hideLoadingProgress();

      if (mounted) {
        showSuccessMessage(context, "Altura cadastrada com sucesso!");

        _goToImcPage(context);
      }
    } else {
      showErrorMessage(context, messageValidation!);

      _resetState();
    }
  }

  void _validateHeight() {
    setState(() {
      messageValidation =
          FormFieldValidation.alturaValidation(alturaController.text);
      if (messageValidation != null) {
        isValid = false;
      }
    });
  }

  void _showLoadingProgress() {
    setState(() {
      loading = true;
    });
  }

  Future<void> _addAltura() async {
    setState(() {
      altura = convertStringToDouble(alturaController.text);
    });

    try {
      await repository.addAltura(CalculadoraImc(altura: altura));
    } catch (e) {
      if (mounted) {
        showErrorMessage(context, "Houve um erro ao tentar cadastar a Altura!");
      }
    }
  }

  void _hideLoadingProgress() {
    setState(() {
      loading = false;
    });
  }

  void _resetState() {
    setState(() {
      isValid = true;
    });
  }

  void _goToImcPage(BuildContext context) {
    Navigator.pop(context);
  }
}

class _AddAltura extends StatelessWidget {
  const _AddAltura({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.send_rounded,
        ));
  }
}
