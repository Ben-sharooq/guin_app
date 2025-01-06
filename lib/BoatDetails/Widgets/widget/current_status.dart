import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guin/Home/Controller/homeController.dart';
import 'package:guin/constants/app_image.dart';
import 'package:guin/constants/constant_values.dart';
import 'package:guin/constants/responsive.dart';


class CurrentStatus extends StatelessWidget {
  const CurrentStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NetworkController>();
    double power1 = 0.0;
    double power2 = 0.0;

    // Battery Power Calculation
    if (controller.navModel.isNotEmpty &&
        controller.boatDetails.isNotEmpty &&
        controller.boatDetails[0].data.isNotEmpty) {
      final eb = double.tryParse(controller.navModel[0].data!.eb?.toString() ?? "0") ?? 0.0;

      if (controller.boatDetails[0].data[0].soc != null) {
        power1 = eb * (controller.boatDetails[0].data[0].soc! / 100);
      }

      if (controller.boatDetails.length > 1 &&
          controller.boatDetails[1].data.length > 1 &&
          controller.boatDetails[1].data[1].soc != null) {
        power2 = eb * (controller.boatDetails[1].data[1].soc! / 100);
      }
    }

    double batteryLevel1 = controller.boatDetails.isNotEmpty &&
            controller.boatDetails[0].data.isNotEmpty &&
            controller.boatDetails[0].data[0].soc != null
        ? controller.boatDetails[0].data[0].soc!.toDouble()
        : 0.0;

    double batteryLevel2 = controller.boatDetails.length > 1 &&
            controller.boatDetails[1].data.isNotEmpty &&
            controller.boatDetails[1].data[1].soc != null
        ? controller.boatDetails[1].data[1].soc!.toDouble()
        : 0.0;

    String batteryIcon1 = _getBatteryIcon(batteryLevel1);
    String batteryIcon2 = _getBatteryIcon(batteryLevel2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBatteryBox(
          context,
          title: ConstantText.batteryBox1,
          power: power1,
          batteryLevel: batteryLevel1,
          batteryIcon: batteryIcon1,
          soc: controller.boatDetails.isNotEmpty
              ? controller.boatDetails[0].data[0].soc
              : null,
          packCurrent: controller.boatDetails.isNotEmpty &&
        controller.boatDetails[0].data.isNotEmpty
    ? (controller.boatDetails[0].data[0].packCurrent ?? "0").toString()
    : "0",
        ),
        const VerticalDivider(indent: 15, endIndent: 15),
        _buildBatteryBox(
  context,
  title: ConstantText.batteryBox2,
  power: power2,
  batteryLevel: batteryLevel2,
  batteryIcon: batteryIcon2,
  soc: controller.boatDetails.length > 1 &&
          controller.boatDetails[1].data.length > 1
      ? controller.boatDetails[1].data[1].soc
      : null,
  packCurrent: controller.boatDetails.length > 1 &&
          controller.boatDetails[1].data.length > 1
      ? (controller.boatDetails[1].data[1].packCurrent ?? "0").toString()
      : "0",
),

      ],
    );
  }

  String _getBatteryIcon(double batteryLevel) {
    if (batteryLevel >= 0 && batteryLevel <= 40) {
      return AppImage.batteryLow;
    } else if (batteryLevel > 40 && batteryLevel <= 70) {
      return AppImage.batteryMedium;
    } else {
      return AppImage.batteryFull;
    }
  }

  Widget _buildBatteryBox(
    BuildContext context, {
    required String title,
    required double power,
    required double batteryLevel,
    required String batteryIcon,
    required double? soc,
    required String packCurrent,
  }) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 30),
              Image.asset(
                packCurrent == "0" ? AppImage.batteryOFF : AppImage.batteryON,
                scale: 15,
              ),
            ],
          ),
          Text(
            "Capacity: ${power.toStringAsFixed(1)} kWh",
            style: const TextStyle(
              fontSize: 10,
              color: Color.fromARGB(255, 182, 181, 181),
            ),
          ),
          Row(
            children: [
              Image.asset(
                batteryIcon,
                width: 48.w,
                height: 130.h,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Net",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                  ),
                  Text(
                    "Capacity",
                    style: TextStyle(
                        fontSize: Responsive.isDesktop(context) ? 22.sp : 22,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "${power.toStringAsFixed(1)} kWh",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          _buildSOCAndSOH(context, label: "SOC", value: "${soc ?? 0}%"),
          _buildSOCAndSOH(context, label: "SOH", value: "100%"),
        ],
      ),
    );
  }

  Widget _buildSOCAndSOH(BuildContext context, {required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: Responsive.isDesktop(context) ? 25.sp : 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 40),
            Text(
              value,
              style: TextStyle(
                  fontSize: Responsive.isDesktop(context) ? 23.sp : 23,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: Colors.grey,
          width: 80,
          height: 1,
        ),
      ],
    );
  }
}
