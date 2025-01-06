
import 'package:flutter/material.dart';
import 'package:guin/Co2_chart/model/graph_model.dart';


class CarbonGraph extends StatelessWidget {
  final List<CarbonEmissionData> data;

  CarbonGraph({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(child: Text('No data available for the selected period.'));
    }

    // Replace with your charting library or custom graph implementation
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return ListTile(
          title: Text('Date: ${item.reportDatetime}'),
          subtitle: Text('Value: ${item.carbonEmission}'),
        );
      },
    );
  }
}
