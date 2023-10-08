class CalculadoraImc {
  final int? id;
  final double? peso;
  final double? altura;
  final String? classificacao;

  const CalculadoraImc({this.id, this.peso, this.altura, this.classificacao});

  factory CalculadoraImc.fromJson(Map<String, dynamic> json) {
    return CalculadoraImc(
      id: json['id'],
      peso: json['peso'],
      altura: json['altura'],
      classificacao: json['classificacao'],
    );
  }

  CalculadoraImc copyWith(
      {int? id, double? peso, double? altura, String? classificacao}) {
    return CalculadoraImc(
      id: id ?? this.id,
      peso: peso ?? this.peso,
      altura: altura ?? this.altura,
      classificacao: classificacao ?? this.classificacao,
    );
  }
}
