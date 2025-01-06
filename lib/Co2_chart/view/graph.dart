import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guin/Co2_chart/view/widget/fl_chart.dart';
import 'package:guin/Home/Controller/homeController.dart';

class CarbonEmissionView extends StatelessWidget {
  final NetworkController controller = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carbon Emission Graph"),
      ),
      body: Obx(() {
        if (controller.isCo2chartLoding.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            DropdownButton<String>(
              value: 'Live',
              items: ['Live', 'Day', 'Month', 'Year']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                // Handle period change
              },
            ),
            Expanded(
              child: CarbonGraph(data: controller.Co2chart()),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.Co2chart,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
