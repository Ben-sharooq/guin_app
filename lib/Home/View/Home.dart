
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:guin/BoatDetails/View/DetailsScreen/NavDetailsScreen.dart';
import 'package:guin/Co2_chart/view/widget/fl_chart.dart';
import 'package:guin/Home/Controller/homeController.dart';
import 'package:guin/Home/View/Widget/activity_details_card.dart';
import 'package:guin/Home/View/Widget/boat_card.dart';
import 'package:guin/Home/View/Widget/custom_card.dart';

import 'package:guin/Home/View/Widget/header_widget.dart';
import 'package:guin/Home/View/our_vessels.dart';
import 'package:guin/constants/constants.dart';
import 'package:guin/constants/responsive.dart';

import 'package:shimmer/shimmer.dart';
class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomePage({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final networkController = Get.find<NetworkController>();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 15 : 18,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Responsive.isMobile(context) ? 5 : 18),
                    const SizedBox(height: 20),
                    DashboardHeader(scaffoldKey: scaffoldKey),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (networkController.isBoatdataLoading.value) {
                        return const Center(
                          child: SpinKitFadingCube(
                            color: Color(0xFF0F0F79),
                            size: 30.0,
                          ),
                        );
                      }

                      return SizedBox(
                        height: 155,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: networkController.navModel.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final modelData =
                                      networkController.navModel[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          networkController.fetchBoatDetails(
                                              modelData.data!);
                                          Get.to(() => NavBoatDetailsScreen(
                                              modelData: modelData.data!));
                                        },
                                        child: BoatCard(
                                          modelData: modelData.data!,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Get.to(
                                //   OurVesselPage(scaffoldKey: scaffoldKey),
                                // );
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (networkController.isBoatdataLoading.value) {
                        return Shimmer.fromColors(
                          direction: ShimmerDirection.ltr,
                          baseColor: cardBackgroundColor,
                          highlightColor:
                              const Color.fromARGB(255, 121, 121, 121),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 300),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    Responsive.isMobile(context) ? 2 : 5,
                                crossAxisSpacing:
                                    Responsive.isMobile(context) ? 15 : 8,
                                mainAxisSpacing: 8.0,
                              ),
                              itemBuilder: (context, i) {
                                return const CustomCard(child: SizedBox());
                              },
                            ),
                          ),
                        );
                      } else if (networkController.navModel.isNotEmpty) {
                        return ActivityDetailsCard(
                          totalCo2Trees: networkController
                              .totalCo2TressData.value.total![0],
                          boatCount: networkController.navModel.length,
                        );
                      }
                      return const Center(
                        child: Text("No Data Available"),
                      );
                    }),
                    const SizedBox(height: 20),
                    Obx(() {
        if (networkController.isCo2chartLoding.value) {
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
              child: CarbonGraph(data: networkController.getLiveData()),
            ),
          ],
        );
      }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
