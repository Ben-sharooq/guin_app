import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:guin/Home/Controller/homeController.dart';
import 'package:guin/Home/View/Widget/activity_details_card.dart';
import 'package:guin/Home/View/Widget/boat_card.dart';
import 'package:guin/Home/View/Widget/custom_card.dart';
import 'package:guin/constants/constants.dart';
import 'package:guin/constants/responsive.dart';
import 'package:shimmer/shimmer.dart';

class OurVesselPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  OurVesselPage({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final networkController = Get.find<NetworkController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 15 : 18,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: Responsive.isMobile(context) ? 5 : 18),
                  const SizedBox(height: 70),
                  Center(
                    child: Text(
                      'Our Vessels',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Obx(() {
                  //   if (networkController.isLoading.value) {
                  //     return Shimmer.fromColors(
                  //       direction: ShimmerDirection.ltr,
                  //       baseColor: cardBackgroundColor,
                  //       highlightColor:
                  //           const Color.fromARGB(255, 121, 121, 121),
                  //       child: GridView.builder(
                  //         itemCount: 5,
                  //         shrinkWrap: true,
                  //         physics: const ScrollPhysics(),
                  //         gridDelegate:
                  //             SliverGridDelegateWithFixedCrossAxisCount(
                  //           crossAxisCount:
                  //               Responsive.isMobile(context) ? 2 : 5,
                  //           crossAxisSpacing:
                  //               !Responsive.isMobile(context) ? 15 : 12,
                  //           mainAxisSpacing: 10.0,
                  //         ),
                  //         itemBuilder: (context, i) {
                  //           return const CustomCard(
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: [],
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     );
                  //   } else if (networkController.navModel.isNotEmpty) {
                  //     final totalData =
                  //         networkController.totalCo2TressData.value.total;
                  //     if (totalData != null && totalData.isNotEmpty) {
                  //       return ActivityDetailsCard(
                  //         totalCo2Trees: totalData[0],
                  //         boatCount: networkController.navModel.length,
                  //       );
                  //     }
                  //   }
                  //   return const SizedBox.shrink(); // Fallback if no data
                  // }),
                  const SizedBox(height: 20),
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
                    } else if (networkController.navModel.isEmpty) {
                      return const Center(
                        child: Text("No boat data available"),
                      );
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2.0,
                      ),
                      itemCount: networkController.navModel.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final modelData = networkController.navModel[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: BoatCard(modelData: modelData.data!),
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
