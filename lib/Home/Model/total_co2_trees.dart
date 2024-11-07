// To parse this JSON data, do
//
//     final totalCo2TressModel = totalCo2TressModelFromJson(jsonString);

import 'dart:convert';

TotalCo2TressModel totalCo2TressModelFromJson(String str) =>
    TotalCo2TressModel.fromJson(json.decode(str));

String totalCo2TressModelToJson(TotalCo2TressModel data) =>
    json.encode(data.toJson());

class TotalCo2TressModel {
  List<Total>? total;

  TotalCo2TressModel({
    this.total,
  });

  factory TotalCo2TressModel.fromJson(Map<String, dynamic> json) =>
      TotalCo2TressModel(
        total: List<Total>.from(json["total"].map((x) => Total.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": List<dynamic>.from(total!.map((x) => x.toJson())),
      };
}

class Total {
  double? tlDieselConsumedSoFar;
  double? totalCarbonEmissionSoFar;
  double? treesPlantedSoFar;
  double? totalCostSavingFuel;
  double? totalRunHrs;

  Total({
    this.tlDieselConsumedSoFar,
    this.totalCarbonEmissionSoFar,
    this.treesPlantedSoFar,
    this.totalCostSavingFuel,
    this.totalRunHrs,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        tlDieselConsumedSoFar: json["tl_diesel_consumed_so_far"].toDouble(),
        totalCarbonEmissionSoFar:
            json["total_carbon_emission_so_far"].toDouble(),
        treesPlantedSoFar: json["trees_planted_so_far"].toDouble(),
        totalCostSavingFuel: json["total_cost_saving_fuel"].toDouble(),
        totalRunHrs: json["total_run_hrs"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "tl_diesel_consumed_so_far": tlDieselConsumedSoFar,
        "total_carbon_emission_so_far": totalCarbonEmissionSoFar,
        "trees_planted_so_far": treesPlantedSoFar,
        "total_cost_saving_fuel": totalCostSavingFuel,
        "total_run_hrs": totalRunHrs,
      };
}
