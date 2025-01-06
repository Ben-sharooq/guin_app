import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Example GraphData class to parse the raw data
class GraphData {
  final DateTime dateTime;
  final double value;

  GraphData({required this.dateTime, required this.value});

  // Factory method to create GraphData from JSON and a specific display key
  factory GraphData.fromJson(Map<String, dynamic> json, String key) {
    return GraphData(
      dateTime: DateTime.parse(json['report_datetime']),
      value: json[key]?.toDouble() ?? 0.0,
    );
  }
}

class GraphPage extends StatefulWidget {
  final List<Map<String, dynamic>> rawData;
  final String displayKey;

  const GraphPage({
    required this.rawData,
    required this.displayKey,
    Key? key,
  }) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  late List<GraphData> graphData;

  @override
  void initState() {
    super.initState();
    // Parse raw data into GraphData objects
    graphData = widget.rawData
        .map((item) => GraphData.fromJson(item, widget.displayKey))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.displayKey} Graph'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          _createLineChartData(),
        ),
      ),
    );
  }

  LineChartData _createLineChartData() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
              return Text(
                '${date.day}/${date.month}',
                style: TextStyle(fontSize: 10),
              );
            },
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(show: true),
      lineBarsData: [
        LineChartBarData(
          spots: graphData
              .map((data) => FlSpot(
                    data.dateTime.millisecondsSinceEpoch.toDouble(),
                    data.value,
                  ))
              .toList(),
          isCurved: true,
          color: Colors.blue,
          barWidth: 4,
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }
}
