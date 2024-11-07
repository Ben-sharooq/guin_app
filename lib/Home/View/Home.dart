import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:guin/Home/Controller/homeController.dart';
import 'package:guin/Home/View/Widget/activity_details_card.dart';
import 'package:guin/Home/View/Widget/all_boat_list.dart';
import 'package:guin/Home/View/Widget/boat_card.dart';
import 'package:guin/Home/View/Widget/custom_card.dart';
import 'package:guin/Home/View/Widget/header_widget.dart';

import 'package:guin/constants/constants.dart';
import 'package:guin/constants/responsive.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  HomePage({Key? key, required this.scaffoldKey}) : super(key: key);
  int selectedChartIndex = 0;

  void onChartClicked(int index) {}

  @override
  Widget build(BuildContext context) {
    final networkController = Get.find<NetworkController>();

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 15 : 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: Responsive.isMobile(context) ? 5 : 18),
                DashboardHeader(scaffoldKey: scaffoldKey),
                const SizedBox(height: 20), // Adjust according to your spacing
                Obx(() {
                  if (networkController.isLoading.value) {
                    return const Center(
                      child: SizedBox(
                        height: 155,
                        child: SpinKitFadingCube(
                          color: Color(0xFF0F0F79),
                          size: 30.0,
                        ),
                      ),
                    );
                  }
                  //  else if (networkController.errorMessage.isNotEmpty) {
                  //   return const Center(
                  //     child: Text("Check your network connection"),
                  //   );
                  // } else if (networkController.navModel.isEmpty) {
                  //   return const Center(
                  //     child: Text("No boat data available"),
                  //   );
                  // }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 155,
                          child: ListView.builder(
                            itemCount: Responsive.isMobile(context)
                                ? 1
                                : (Responsive.isDesktop(context)
                                    ? (networkController.navModel.length >= 3
                                        ? 3
                                        : networkController.navModel.length)
                                    : (networkController.navModel.length >= 2
                                        ? 2
                                        : networkController.navModel.length)),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(left: 10, right: 30),
                            scrollDirection: Axis.horizontal,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              final modelData =
                                  networkController.navModel[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: BoatCard(modelData: modelData.data!),
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Boat List'),
                                  actions: [
                                    AllBoatListWidget(
                                      navModelData: networkController.navModel,
                                      totalCo2TressModel: networkController
                                          .totalCo2TressData.value,
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20), // Adjust according to your spacing
                Obx(() {
                  if (networkController.isLoading.value) {
                    return Shimmer.fromColors(
                      direction: ShimmerDirection.ltr,
                      baseColor: cardBackgroundColor,
                      highlightColor: const Color.fromARGB(255, 121, 121, 121),
                      child: GridView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Responsive.isMobile(context) ? 2 : 5,
                          crossAxisSpacing:
                              !Responsive.isMobile(context) ? 15 : 12,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context, i) {
                          return const CustomCard(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (networkController.navModel.isNotEmpty) {
                    // Safely access total and check if it has elements
                    final totalData =
                        networkController.totalCo2TressData.value.total;

                    // // Check if totalData is not null and has at least one element
                    // if (totalData != null && totalData.isNotEmpty) {
                    //   return ActivityDetailsCard(
                    //     totalCo2Trees: totalData[0], // Safe access to the first element
                    //     boatCount: networkController.navModel.length,
                    //   );
                    // }
                  }
                  return const SizedBox.shrink(); // Fallback if no data
                }),
                Obx(() {
                  if (networkController.isLoading1.value) {
                    return Shimmer.fromColors(
                      direction: ShimmerDirection.ltr,
                      baseColor: cardBackgroundColor,
                      highlightColor: const Color.fromARGB(255, 121, 121, 121),
                      child: GridView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Responsive.isMobile(context) ? 2 : 5,
                          crossAxisSpacing:
                              !Responsive.isMobile(context) ? 15 : 12,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context, i) {
                          return const CustomCard(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (networkController.navModel.isNotEmpty) {
                    return ActivityDetailsCard(
                      totalCo2Trees: networkController.totalCo2TressData.value
                          .total![0], // Adjust if necessary
                      boatCount: networkController.navModel.length,
                    );
                  }
                  return const SizedBox.shrink(); // Fallback if no data
                }),

                const SizedBox(height: 20), // Adjust according to your spacing
                // Column(
                //   children: [
                //     LineChartCard(selectedIndex: 0), // You can handle selected index if needed
                //     const SizedBox(height: 20),
                //     GridView.count(
                //       shrinkWrap: true,
                //       physics: const ScrollPhysics(),
                //       crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
                //       crossAxisSpacing: !Responsive.isMobile(context) ? 15 : 12,
                //       mainAxisSpacing: 12.0,
                //       childAspectRatio: Responsive.isMobile(context) ? 16 / 9 : 5 / 4,
                //       children: [
                //         InkWell(
                //           onTap: () => networkController.onChartClicked(0), // Adjust your method to handle this
                //           child: const Co2Chart(),
                //         ),
                //         InkWell(
                //           onTap: () => networkController.onChartClicked(1), // Adjust your method to handle this
                //           child: const TressChart(),
                //         ),
                //         InkWell(
                //           onTap: () => networkController.onChartClicked(2), // Adjust your method to handle this
                //           child: const DieselChart(),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
