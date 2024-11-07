// To parse this JSON data, do

//     final navBoatModelData = navBoatModelDataFromJson(jsonString);

import 'dart:convert';

List<NavBoatModelData> navBoatModelDataFromJson(String str) =>
    List<NavBoatModelData>.from(
        json.decode(str).map((x) => NavBoatModelData.fromJson(x)));

String navBoatModelDataToJson(List<NavBoatModelData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NavBoatModelData {
  String? name;
  int? id;
  Data? data;

  NavBoatModelData({
    this.name,
    this.id,
    this.data,
  });

  factory NavBoatModelData.fromJson(Map<String, dynamic> json) =>
      NavBoatModelData(
        name: json["name"],
        id: json["id"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "data": data!.toJson(),
      };
}

class Data {
  String? name;
  int? bBox;
  String? bBox2Name;
  String? bBox1Value;
  double? eb;
  String? bBox1Name;
  int? id;
  String? bBox2Value;
  double? totalRunHrs;
  String? url;
  String? boatStatus;
  double? tlDieselConsumed;
  double? totalCarbonEmission;
  double? treesPlanted;

  Data({
    this.name,
    this.bBox,
    this.bBox2Name,
    this.bBox1Value,
    this.eb,
    this.bBox1Name,
    this.id,
    this.bBox2Value,
    this.totalRunHrs,
    this.url,
    this.boatStatus,
    this.tlDieselConsumed,
    this.totalCarbonEmission,
    this.treesPlanted,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        bBox: json["b_box"],
        bBox2Name: json["b_box_2_name"],
        bBox1Value: json["b_box_1_value"],
        eb: json["eb"].toDouble(),
        bBox1Name: json["b_box_1_name"],
        id: json["id"],
        bBox2Value: json["b_box_2_value"],
        totalRunHrs: json["total_run_hrs"].toDouble(),
        url: json["url"],
        boatStatus: json["boat_status"],
        tlDieselConsumed: json["tl_diesel_consumed"].toDouble(),
        totalCarbonEmission: json["total_carbon_emission"].toDouble(),
        treesPlanted: json["trees_planted"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "b_box": bBox,
        "b_box_2_name": bBox2Name,
        "b_box_1_value": bBox1Value,
        "eb": eb,
        "_1_name": bBox1Name,
        "id": id,
        "b_box_2_value": bBox2Value,
        "total_run_hrs": totalRunHrs,
        "url": url,
        "boat_status": boatStatus,
        "tl_diesel_consumed": tlDieselConsumed,
        "total_carbon_emission": totalCarbonEmission,
        "trees_planted": treesPlanted,
      };
}
