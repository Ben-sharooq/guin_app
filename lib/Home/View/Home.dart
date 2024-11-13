import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:guin/BoatDetails/View/DetailsScreen/NavDetailsScreen.dart';
import 'package:guin/Home/Controller/homeController.dart';
import 'package:guin/Home/Model/all_boat_data.dart';
import 'package:guin/Home/View/Widget/activity_details_card.dart';
import 'package:guin/Home/View/Widget/all_boat_list.dart';
import 'package:guin/Home/View/Widget/boat_card.dart';
import 'package:guin/Home/View/Widget/custom_card.dart';
import 'package:guin/Home/View/Widget/header_widget.dart';
import 'package:guin/Home/View/our_vessels.dart';

import 'package:guin/constants/constants.dart';
import 'package:guin/constants/responsive.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  HomePage({Key? key, required this.scaffoldKey}) : super(key: key);

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
                  const SizedBox(height: 20,),
                  DashboardHeader(scaffoldKey: scaffoldKey),
                  const SizedBox(height: 20),
                  Obx(() {
                    if (networkController.isBoatdataLoading.value) {
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
              
                    // Set a defined height here to avoid infinite constraints
                    return SizedBox(
                      height: 155, // Define height to prevent infinite constraint
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: Responsive.isMobile(context)
                                  ? 1
                                  : networkController.navModel.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final modelData = networkController.navModel[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    onTap: () {
                                      networkController
                                          .fetchBoatDetails(modelData.data!);
                                      Get.to(() => NavBoatDetailsScreen(
                                          modelData: modelData.data!));
                                    },
                                    child: BoatCard(modelData: modelData.data!),
                                  ),
                                );
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(OurVesselPage(scaffoldKey: scaffoldKey));
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
                  const SizedBox(height: 20),
                  Obx(() {
                    if (networkController.isBoatdataLoading.value) {
                      return Shimmer.fromColors(
                        direction: ShimmerDirection.ltr,
                        baseColor: cardBackgroundColor,
                        highlightColor: const Color.fromARGB(255, 121, 121, 121),
                        child: SizedBox(
                          height: 300,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Responsive.isMobile(context) ? 2 : 5,
                              crossAxisSpacing: !Responsive.isMobile(context) ? 15 : 12,
                              mainAxisSpacing: 10.0,
                            ),
                            itemBuilder: (context, i) {
                              return const CustomCard(child: SizedBox());
                            },
                          ),
                        ),
                      );
                    } else if (networkController.navModel.isNotEmpty) {
                      return ActivityDetailsCard(
                        totalCo2Trees: networkController.totalCo2TressData.value.total![0],
                        boatCount: networkController.navModel.length,
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  const SizedBox(height: 20),
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
