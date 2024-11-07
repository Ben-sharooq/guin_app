
import 'dart:convert';

TotalCo2TressPeriodWiseModel totalCo2TressPeriodWiseModelFromJson(String str) =>
    TotalCo2TressPeriodWiseModel.fromJson(json.decode(str));

String totalCo2TressPeriodWiseModelToJson(TotalCo2TressPeriodWiseModel data) =>
    json.encode(data.toJson());

class TotalCo2TressPeriodWiseModel {
  List<Datum>? data;

  TotalCo2TressPeriodWiseModel({
    this.data,
  });

  factory TotalCo2TressPeriodWiseModel.fromJson(Map<String, dynamic> json) =>
      TotalCo2TressPeriodWiseModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic reportDatetime;
  double? totalCarbonEmission;
  double? tlDieselConsumed;
  double? tressPlanted;

  Datum({
    this.reportDatetime,
    this.totalCarbonEmission,
    this.tlDieselConsumed,
    this.tressPlanted,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        reportDatetime: json["report_datetime"],
        // reportDatetime: DateTime.parse(json["report_datetime"]),
        totalCarbonEmission: json["total_carbon_emission"].toDouble(),
        tlDieselConsumed: json["tl_diesel_consumed"].toDouble(),
        tressPlanted: json["tress_planted"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "report_datetime": reportDatetime,
        // "report_datetime": reportDatetime!.toIso8601String(),
        "total_carbon_emission": totalCarbonEmission,
        "tl_diesel_consumed": tlDieselConsumed,
        "tress_planted": tressPlanted,
      };
}
