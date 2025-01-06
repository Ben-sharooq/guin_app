import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guin/AMC/view/detailed_view.dart';
import 'package:guin/Home/Controller/homeController.dart';

class AmcBoatListScreen extends StatelessWidget {
  final NetworkController controller = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AMC Boats'),
      ),
      body: Obx(() {
        if (controller.isAmcLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.AmcBoats.isEmpty) {
          return const Center(child: Text('No boats available.'));
        }

        return ListView.builder(
          itemCount: controller.AmcBoats.length,
          itemBuilder: (context, index) {
            final boat = controller.AmcBoats[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Boat Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        boat.url,
                        height: 150,
                        width: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Boat Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            boat.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.business,
                                size: 16,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                boat.boatOwner,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                boat.operatingArea,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Colors.blue,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'AMC Start: ${boat.amcStartDate} - AMC End: ${boat.amcEndDate}',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'YOB: ${boat.yob}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigate to detailed view
                                  Get.to(() => BoatDetailScreen(boat: boat));
                                },
                                child: const Text(
                                  'Details',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
