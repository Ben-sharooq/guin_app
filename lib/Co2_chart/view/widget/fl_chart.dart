import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:guin/Co2_chart/model/graph_model.dart';

class CarbonGraph extends StatelessWidget {
  final List<CarbonEmissionData> data;

  const CarbonGraph({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: data
                .map((e) => FlSpot(
                      e.reportDatetime.millisecondsSinceEpoch.toDouble(),
                      e.carbonEmission,
                    ))
                .toList(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
          ),
        ],
      ),
    );
  }
}
