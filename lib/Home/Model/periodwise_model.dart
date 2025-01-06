class TotalCo2TressPeriodWiseModel2 {
  final List<Co2TressData> data;

  TotalCo2TressPeriodWiseModel2({required this.data});

  factory TotalCo2TressPeriodWiseModel2.fromJson(Map<String, dynamic> json) {
    return TotalCo2TressPeriodWiseModel2(
      data: (json['data'] as List)
          .map((item) => Co2TressData.fromJson(item))
          .toList(),
    );
  }
}

class Co2TressData {
  final String date;
  final double co2Emission;
  final double dieselUsage;
  final int treesPlanted;

  Co2TressData({
    required this.date,
    required this.co2Emission,
    required this.dieselUsage,
    required this.treesPlanted,
  });

  factory Co2TressData.fromJson(Map<String, dynamic> json) {
    return Co2TressData(
      date: json['date'],
      co2Emission: json['co2_emission'].toDouble(),
      dieselUsage: json['diesel_usage'].toDouble(),
      treesPlanted: json['trees_planted'],
    );
  }
}
