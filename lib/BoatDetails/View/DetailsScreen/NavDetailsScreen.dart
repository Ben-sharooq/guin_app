import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guin/BoatDetails/View/mobile_view.dart';
import 'package:guin/BoatDetails/View/tablet_view.dart';
import 'package:guin/BoatDetails/View/web_view.dart';
import 'package:guin/Home/Controller/homeController.dart';
import 'package:guin/constants/responsive.dart';

class NavBoatDetailsScreen extends StatelessWidget {
  final dynamic modelData;
  final dynamic boatDetailsRequest;

  const NavBoatDetailsScreen({
    super.key,
    required this.boatDetailsRequest,
    required this.modelData,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NetworkController>();

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed('/home'); // Navigate to home page on back
        return false;
      },
      child: Scaffold(
        body: Obx(() {
          // Check loading state and error message
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          } else if (controller.boatDetails.isEmpty) {
            return const Center(child: Text("boat Details is empty"));
          }

          // Get latitude and longitude from the boat details
          final double latitude = double.tryParse(
                  controller.boatDetails[0].bBox1?.latitude ?? '0.0') ??
              0.0;
          final double longitude = double.tryParse(
                  controller.boatDetails[0].bBox1?.longitude ?? '0.0') ??
              0.0;

          return ResponsiveLayout(
            mobileBody: MobileBody(
              navmodel: modelData,
              latitude: latitude,
              longitude: longitude,
              snapshotData: boatDetailsRequest,
            ),
            desktopBody: DesktopBody(
              navmodel: modelData,
              latitude: latitude,
              longitude: longitude,
              snapshotData: boatDetailsRequest,
            ),
            tabletBody: TabletBody(
              navmodel: modelData,
              latitude: latitude,
              longitude: longitude,
              snapshotData: boatDetailsRequest,
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
