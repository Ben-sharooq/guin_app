// main_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guin/Co2_chart/view/widget/fl_chart.dart';
import 'package:guin/Home/Controller/homeController.dart';


class Co2ChartPage extends StatelessWidget {
  final NetworkController networkController = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Co2 Emission Graph')),
      body: Obx(() {
        if (networkController.isCo2chartLoding.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (networkController.errorMessage.value.isNotEmpty) {
          return Center(child: Text(networkController.errorMessage.value));
        }

        return Column(
          children: [
            DropdownButton<String>(
              value: networkController.selectedPeriod.value,
              items: ['Live', 'Day', 'Month', 'Year']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  networkController.selectedPeriod.value = value;
                }
              },
            ),
            Expanded(
              child: CarbonGraph(data: networkController.getFilteredData()),
            ),
          ],
        );
      }),
    );
  }
}
