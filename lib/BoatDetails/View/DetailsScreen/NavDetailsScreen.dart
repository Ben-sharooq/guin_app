import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:guin/BoatDetails/View/mobile_view.dart';
import 'package:guin/BoatDetails/View/tablet_view.dart';
import 'package:guin/BoatDetails/View/web_view.dart';
import 'package:guin/Home/Controller/homeController.dart';
import 'package:guin/Home/Model/all_boat_data.dart';
import 'package:guin/Home/View/Home.dart';
import 'package:guin/constants/responsive.dart';

class NavBoatDetailsScreen extends StatelessWidget {
  final Data modelData;

  const NavBoatDetailsScreen({
    Key? key,
    required this.modelData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NetworkController>();

    return WillPopScope(
      onWillPop: () async {
        Get.off(HomePage(
            scaffoldKey: GlobalKey())); // Navigate to home page on back
        return false;
      },
      child: Scaffold(
        body: Obx(() {
          // Check loading state and error message
          if (controller.isBoatdataLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          } else if (controller.boatDetails.isEmpty) {
            return const Center(
              child: SpinKitFadingCube(
                color: Color(0xFF0F0F79),
                size: 30.0,
              ),
            );
          }
          // Get latitu;de and longitude from the boat details
          final double latitude = double.tryParse(
                  controller.boatDetails[0].data[0].latitude ?? '0.0') ??
              0.0;
          final double longitude = double.tryParse(
                  controller.boatDetails[0].data[0].longitude ?? '0.0') ??
              0.0;

          return ResponsiveLayout(
            mobileBody: MobileBody(
              navmodel: modelData,
              latitude: latitude,
              longitude: longitude,
              snapshotData: controller.boatDetails,
            ),
            desktopBody: DesktopBody(
              navmodel: modelData,
              latitude: latitude,
              longitude: longitude,
              snapshotData: controller.boatDetails,
            ),
            tabletBody: TabletBody(
              navmodel: modelData,
              latitude: latitude,
              longitude: longitude,
              snapshotData: controller.boatDetails,
            ),
          );
        }),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;
  final Widget tabletBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.desktopBody,
    required this.tabletBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (Responsive.isDesktop(context)) {
          return desktopBody;
        } else if (Responsive.isMobile(context)) {
          return mobileBody;
        }
        return tabletBody;
      },
    );
  }
}

class Range {
  static double range = 0.0;
  static double speed = 0.0;
}
