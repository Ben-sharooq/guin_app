class CarbonEmissionData {
  final DateTime reportDatetime;
  final double carbonEmission;
  final double treesPlant;
  final double dieselConsumed;
  final double totalCarbonEmission;
  final double tlDieselConsumed;
  final double tressPlanted;

  CarbonEmissionData({
    required this.reportDatetime,
    required this.carbonEmission,
    required this.treesPlant,
    required this.dieselConsumed,
    required this.totalCarbonEmission,
    required this.tlDieselConsumed,
    required this.tressPlanted,
  });

  factory CarbonEmissionData.fromJson(Map<String, dynamic> json) {
    return CarbonEmissionData(
      reportDatetime: DateTime.parse(json['report_datetime']),
      carbonEmission: json['carbon_emission'],
      treesPlant: json['trees_plant'],
      dieselConsumed: json['diesel_consumed'],
      totalCarbonEmission: json['total_carbon_emission'],
      tlDieselConsumed: json['tl_diesel_consumed'],
      tressPlanted: json['tress_planted'],
    );
  }
}
