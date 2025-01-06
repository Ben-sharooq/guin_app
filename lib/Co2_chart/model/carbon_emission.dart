class CarbonEmissionData {
  final DateTime reportDatetime;
  final double? carbonEmissionValue; 

  CarbonEmissionData({required this.reportDatetime, this.carbonEmissionValue});

  factory CarbonEmissionData.fromJson(Map<String, dynamic> json) {
    return CarbonEmissionData(
      reportDatetime: DateTime.parse(json['report_datetime']),
      carbonEmissionValue: json['value']?.toDouble(), 
    );
  }
}
