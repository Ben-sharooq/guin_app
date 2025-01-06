class NavBoatDetailsModel2 {
  final List<BatteryBox> data;
  final Range1 range;

  NavBoatDetailsModel2({required this.data, required this.range});

  factory NavBoatDetailsModel2.fromJson(Map<String, dynamic> json) {
    var dataList = (json['data'] as List?)
        ?.map((item) => BatteryBox.fromJson(item))
        .toList();
    return NavBoatDetailsModel2(
      data: dataList!,
      range: Range1.fromJson(json['range']),
    );
  }
}

class BatteryBox {
  final double maxCellVoltage;
  final double vc3;
  final double vc11;
  final String latitude;
  final double minCellVoltageNo;
  final double minCellVoltage;
  final double vc4;
  final double vc12;
  final String longitude;
  final String timestamp;
  final double soh;
  final double vc5;
  final double speed;
  final double maxCellVoltageNo;
  final double soc;
  final double vc6;
  final double vc13;
  final double minCellTempCMU;
  final double cmuVminCell;
  final double vc7;
  final double vc14;
  final double maxCellTempCMU;
  final double cmuVmaxCell;
  final double vc8;
  final double vc15;
  final double packCurrent;
  final double vc1;
  final double vc9;
  final int id;
  final double packVoltage;
  final double vc2;
  final double vc10;
  final String portId;

  BatteryBox({
    required this.maxCellVoltage,
    required this.vc3,
    required this.vc11,
    required this.latitude,
    required this.minCellVoltageNo,
    required this.minCellVoltage,
    required this.vc4,
    required this.vc12,
    required this.longitude,
    required this.timestamp,
    required this.soh,
    required this.vc5,
    required this.speed,
    required this.maxCellVoltageNo,
    required this.soc,
    required this.vc6,
    required this.vc13,
    required this.minCellTempCMU,
    required this.cmuVminCell,
    required this.vc7,
    required this.vc14,
    required this.maxCellTempCMU,
    required this.cmuVmaxCell,
    required this.vc8,
    required this.vc15,
    required this.packCurrent,
    required this.vc1,
    required this.vc9,
    required this.id,
    required this.packVoltage,
    required this.vc2,
    required this.vc10,
    required this.portId,
  });

factory BatteryBox.fromJson(Map<String, dynamic> json) {
  return BatteryBox(
    maxCellVoltage: _toDouble(json['Max_Cell_Voltage']),
    vc3: _toDouble(json['vc3']),
    vc11: _toDouble(json['vc11']),
    latitude: json['latitude'] ?? '0.0',
    minCellVoltageNo: _toDouble(json['Min_Cell_Voltage_no']),
    minCellVoltage: _toDouble(json['Min_Cell_Voltage']),
    vc4: _toDouble(json['vc4']),
    vc12: _toDouble(json['vc12']),
    longitude: json['longitude'] ?? '0.0',
    timestamp: json['timestamp'] ?? '',
    soh: _toDouble(json['SOH']),
    vc5: _toDouble(json['vc5']),
    speed: _toDouble(json['speed']),
    maxCellVoltageNo: _toDouble(json['Max_Cell_Voltage_no']),
    soc: _toDouble(json['SOC']),
    vc6: _toDouble(json['vc6']),
    vc13: _toDouble(json['vc13']),
    minCellTempCMU: _toDouble(json['Min_Cell_Temp_CMU']),
    cmuVminCell: _toDouble(json['CMU_Vmin_Cell']),
    vc7: _toDouble(json['vc7']),
    vc14: _toDouble(json['vc14']),
    maxCellTempCMU: _toDouble(json['Max_Cell_Temp_CMU']),
    cmuVmaxCell: _toDouble(json['CMU_Vmax_Cell']),
    vc8: _toDouble(json['vc8']),
    vc15: _toDouble(json['vc15']),
    packCurrent: _toDouble(json['Pack_Current']),
    vc1: _toDouble(json['vc1']),
    vc9: _toDouble(json['vc9']),
    id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
    packVoltage: _toDouble(json['Pack_Voltage']),
    vc2: _toDouble(json['vc2']),
    vc10: _toDouble(json['vc10']),
    portId: json['port_id'] ?? '',
  );
}



}
double _toDouble(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}
class Range1 {
  final double? range;
  final double? speed;

  Range1({
     this.range,
     this.speed,
  });

  factory Range1.fromJson(Map<String, dynamic> json) {
    return Range1(
      range: json['range'] ?? 0,
      speed: json['speed'] ?? 0,
    );
  }
}
