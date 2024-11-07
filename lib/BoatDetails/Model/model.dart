import 'dart:convert';

class BoatDetailsResponse {
  List<BoatData1>? data;
  Range? range;

  BoatDetailsResponse({this.data, this.range});

  factory BoatDetailsResponse.fromJson(Map<String, dynamic> json) => BoatDetailsResponse(
        data: json["data"] == null
            ? null
            : List<BoatData1>.from(json["data"].map((x) => BoatData1.fromJson(x))),
        range: json["range"] == null ? null : Range.fromJson(json["range"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "range": range?.toJson(),
      };
}

class BoatData1 {
  BBox? bBox1;
  BBox? bBox2;

  BoatData1({this.bBox1, this.bBox2});

  factory BoatData1.fromJson(Map<String, dynamic> json) => BoatData1(
        bBox1: json["b_box_1"] == null ? null : BBox.fromJson(json["b_box_1"]),
        bBox2: json["b_box_2"] == null ? null : BBox.fromJson(json["b_box_2"]),
      );

  Map<String, dynamic> toJson() => {
        "b_box_1": bBox1?.toJson(),
        "b_box_2": bBox2?.toJson(),
      };
}

class BBox {
  String? maxCellVoltage;
  String? vc3;
  String? vc11;
  String? latitude;
  String? minCellVoltageNo;
  String? minCellVoltage;
  String? vc4;
  String? vc12;
  String? longitude;
  String? timestamp;
  String? soh;
  String? vc5;
  double? speed;
  String? maxCellVoltageNo;
  String? soc;
  String? vc6;
  String? vc13;
  String? minCellTempCmu;
  String? cmuVminCell;
  String? vc7;
  String? vc14;
  String? maxCellTempCmu;
  String? cmuVmaxCell;
  String? vc8;
  String? vc15;
  String? packCurrent;
  String? vc1;
  String? vc9;
  int? id;
  String? packVoltage;
  String? vc2;
  String? vc10;
  String? portId;

  BBox({
    this.maxCellVoltage,
    this.vc3,
    this.vc11,
    this.latitude,
    this.minCellVoltageNo,
    this.minCellVoltage,
    this.vc4,
    this.vc12,
    this.longitude,
    this.timestamp,
    this.soh,
    this.vc5,
    this.speed,
    this.maxCellVoltageNo,
    this.soc,
    this.vc6,
    this.vc13,
    this.minCellTempCmu,
    this.cmuVminCell,
    this.vc7,
    this.vc14,
    this.maxCellTempCmu,
    this.cmuVmaxCell,
    this.vc8,
    this.vc15,
    this.packCurrent,
    this.vc1,
    this.vc9,
    this.id,
    this.packVoltage,
    this.vc2,
    this.vc10,
    this.portId,
  });

  factory BBox.fromJson(Map<String, dynamic> json) => BBox(
        maxCellVoltage: json["Max_Cell_Voltage"],
        vc3: json["vc3"],
        vc11: json["vc11"],
        latitude: json["latitude"],
        minCellVoltageNo: json["Min_Cell_Voltage_no"],
        minCellVoltage: json["Min_Cell_Voltage"],
        vc4: json["vc4"],
        vc12: json["vc12"],
        longitude: json["longitude"],
        timestamp: json["timestamp"],
        soh: json["SOH"],
        vc5: json["vc5"],
        speed: json["speed"]?.toDouble(),
        maxCellVoltageNo: json["Max_Cell_Voltage_no"],
        soc: json["SOC"],
        vc6: json["vc6"],
        vc13: json["vc13"],
        minCellTempCmu: json["Min_Cell_Temp_CMU"],
        cmuVminCell: json["CMU_Vmin_Cell"],
        vc7: json["vc7"],
        vc14: json["vc14"],
        maxCellTempCmu: json["Max_Cell_Temp_CMU"],
        cmuVmaxCell: json["CMU_Vmax_Cell"],
        vc8: json["vc8"],
        vc15: json["vc15"],
        packCurrent: json["Pack_Current"],
        vc1: json["vc1"],
        vc9: json["vc9"],
        id: json["id"],
        packVoltage: json["Pack_Voltage"],
        vc2: json["vc2"],
        vc10: json["vc10"],
        portId: json["port_id"],
      );

  Map<String, dynamic> toJson() => {
        "Max_Cell_Voltage": maxCellVoltage,
        "vc3": vc3,
        "vc11": vc11,
        "latitude": latitude,
        "Min_Cell_Voltage_no": minCellVoltageNo,
        "Min_Cell_Voltage": minCellVoltage,
        "vc4": vc4,
        "vc12": vc12,
        "longitude": longitude,
        "timestamp": timestamp,
        "SOH": soh,
        "vc5": vc5,
        "speed": speed,
        "Max_Cell_Voltage_no": maxCellVoltageNo,
        "SOC": soc,
        "vc6": vc6,
        "vc13": vc13,
        "Min_Cell_Temp_CMU": minCellTempCmu,
        "CMU_Vmin_Cell": cmuVminCell,
        "vc7": vc7,
        "vc14": vc14,
        "Max_Cell_Temp_CMU": maxCellTempCmu,
        "CMU_Vmax_Cell": cmuVmaxCell,
        "vc8": vc8,
        "vc15": vc15,
        "Pack_Current": packCurrent,
        "vc1": vc1,
        "vc9": vc9,
        "id": id,
        "Pack_Voltage": packVoltage,
        "vc2": vc2,
        "vc10": vc10,
        "port_id": portId,
      };
}

class Range {
  // Define properties if "range" has any structure.
  // Currently, it's empty, but here’s a placeholder for future additions if necessary.

  Range();

  factory Range.fromJson(Map<String, dynamic> json) => Range();

  Map<String, dynamic> toJson() => {};
}
