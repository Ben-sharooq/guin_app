import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guin/Home/Controller/homeController.dart';
import 'package:guin/Home/Model/alert_model.dart';
import 'package:guin/Home/View/Widget/custom_card.dart';

class Scheduled extends StatelessWidget {
  Scheduled({super.key});

  final networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Alerts",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (networkController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (networkController.errorMessage.isNotEmpty) {
            return Center(child: Text(networkController.errorMessage.value));
          }

          if (networkController.alerts.isEmpty) {
            return const Center(child: Text("No alert"));
          }

          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: networkController.alerts.length,
              itemBuilder: (context, index) {
                Alert alerts = networkController.alerts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: CustomCard(
                    padding: const EdgeInsets.all(0),
                    color: Colors.black,
                    child: ExpansionTile(
                      collapsedShape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.black,
                      title: Text(
                        alerts.name,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "B Box: ${alerts.bBoxName}",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Alert: ${alerts.alert}",
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
