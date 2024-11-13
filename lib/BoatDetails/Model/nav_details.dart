

class NavBoatDetailsModel {
  final BBox? bBox1;
  final BBox? bBox2;

  NavBoatDetailsModel({this.bBox1, this.bBox2});

  factory NavBoatDetailsModel.fromJson(Map<String, dynamic> json) {
    return NavBoatDetailsModel(
      bBox1: json['b_box_1'] != null ? BBox.fromJson(json['b_box_1']) : null,
      bBox2: json['b_box_2'] != null ? BBox.fromJson(json['b_box_2']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'b_box_1': bBox1?.toJson(),
        'b_box_2': bBox2?.toJson(),
      };
}

class BBox {
  int? id;
  String? timestamp, latitude, longitude, speed;
  String? packVoltage, packCurrent, sOH, sOC;
  String? maxCellVoltage, minCellVoltage;
  String? cMUVminCell, cMUVmaxCell;
  String? minCellTempCMU, maxCellTempCMU;
  String? minCellVoltageNo, maxCellVoltageNo;
  List<String?> voltages;

  BBox({
    this.id,
    this.timestamp,
    this.latitude,
    this.longitude,
    this.speed,
    this.packVoltage,
    this.packCurrent,
    this.sOH,
    this.sOC,
    this.maxCellVoltage,
    this.minCellVoltage,
    this.cMUVminCell,
    this.cMUVmaxCell,
    this.minCellTempCMU,
    this.maxCellTempCMU,
    this.minCellVoltageNo,
    this.maxCellVoltageNo,
    required this.voltages,
  });

  factory BBox.fromJson(Map<String, dynamic> json) {
    List<String?> voltages = List.generate(
      15,
      (i) => json['vc${i + 1}']?.toString() ?? '0.0',
    );
    return BBox(
      id: json['id'],
      timestamp: json['timestamp']?.toString() ?? 'N/A',
      latitude: json['latitude']?.toString() ?? 'Unknown',
      longitude: json['longitude']?.toString() ?? 'Unknown',
      speed: json['speed']?.toString() ?? '0.0',
      packVoltage: json['Pack_Voltage']?.toString() ?? '0.0',
      packCurrent: json['Pack_Current']?.toString() ?? '0.0',
      sOH: json['SOH']?.toString() ?? 'N/A',
      sOC: json['SOC']?.toString() ?? '0.0',
      maxCellVoltage: json['Max_Cell_Voltage']?.toString() ?? '0.0',
      minCellVoltage: json['Min_Cell_Voltage']?.toString() ?? '0.0',
      cMUVminCell: json['CMU_Vmin_Cell']?.toString() ?? '0.0',
      cMUVmaxCell: json['CMU_Vmax_Cell']?.toString() ?? '0.0',
      minCellTempCMU: json['Min_Cell_Temp_CMU']?.toString() ?? 'N/A',
      maxCellTempCMU: json['Max_Cell_Temp_CMU']?.toString() ?? 'N/A',
      minCellVoltageNo: json['Min_Cell_Voltage_no']?.toString() ?? 'N/A',
      maxCellVoltageNo: json['Max_Cell_Voltage_no']?.toString() ?? 'N/A',
      voltages: voltages,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'timestamp': timestamp,
      'latitude': latitude,
      'longitude': longitude,
      'speed': speed,
      'Pack_Voltage': packVoltage,
      'Pack_Current': packCurrent,
      'SOH': sOH,
      'SOC': sOC,
      'Max_Cell_Voltage': maxCellVoltage,
      'Min_Cell_Voltage': minCellVoltage,
      'CMU_Vmin_Cell': cMUVminCell,
      'CMU_Vmax_Cell': cMUVmaxCell,
      'Min_Cell_Temp_CMU': minCellTempCMU,
      'Max_Cell_Temp_CMU': maxCellTempCMU,
      'Min_Cell_Voltage_no': minCellVoltageNo,
      'Max_Cell_Voltage_no': maxCellVoltageNo,
    };
    for (int i = 0; i < voltages.length; i++) {
      data['vc${i + 1}'] = voltages[i];
    }
    return data;
  }
}

