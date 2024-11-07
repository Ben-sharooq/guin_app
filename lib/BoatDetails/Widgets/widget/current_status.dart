import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guin/BoatDetails/Model/nav_details.dart';
import 'package:guin/Home/Model/all_boat_data.dart';
import 'package:guin/constants/app_image.dart';
import 'package:guin/constants/constant_values.dart';
import 'package:guin/constants/responsive.dart';

class CurrentStatus extends StatelessWidget {
  final BBox? bBox1;
  final BBox? bBox2;
  final Data model;
  final int batteryBoxCount;
  const CurrentStatus({
    super.key,
    this.bBox1,
    this.bBox2,
    required this.model,
    required this.batteryBoxCount,
  });

  @override
  Widget build(BuildContext context) {
    double power1 = 0.0;
    double power2 = 0.0;
    //battery power
    if (bBox1!.sOC != null) {
      power1 = double.parse(model.eb.toString()) *
          (double.parse(bBox1!.sOC.toString()) / 100);
    }
    
    if (bBox2?.sOC != null) {
      power2 = double.parse(model.eb.toString()) *
          ((double.parse(bBox1!.sOC!.toString()) / 100));
    }
    double batteryLevel1 =
        bBox1!.sOC != null ? double.parse(bBox1!.sOC.toString()) : 0.0;
    // double batteryLevel2 = double.parse(bBox2!.sOC!.toString())  ?? 0;
    // double batteryLevel2 = bBox2?.sOC != null ? double.parse(bBox2!.sOC!) : 0.0;
    double batteryLevel2 = double.tryParse(bBox2?.sOC ?? '') ?? 0.0;

    String batteryIcon1;
    String batteryIcon2;
    if (batteryLevel1 >= 0 && batteryLevel1 <= 40) {
      batteryIcon1 = AppImage.batteryLow;
    } else if (batteryLevel1 > 40 && batteryLevel1 <= 70) {
      batteryIcon1 = AppImage.batteryMedium;
    } else {
      batteryIcon1 = AppImage.batteryFull;
    }

    if (batteryLevel2 >= 0 && batteryLevel2 <= 40) {
      batteryIcon2 = AppImage.batteryLow;
    } else if (batteryLevel2 > 40 && batteryLevel2 <= 70) {
      batteryIcon2 = AppImage.batteryMedium;
    } else {
      batteryIcon2 = AppImage.batteryFull;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ConstantText.batteryBox1,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 30),
                  bBox1!.packCurrent == "0"
                      ? Image.asset(
                          AppImage.batteryOFF,
                          scale: 15,
                        )
                      : Image.asset(
                          AppImage.batteryON,
                          scale: 15,
                          alignment: Alignment.topRight,
                        )
                ],
              ),
              Text(
                "Capacity: ${model.eb.toString()} kWh",
                style: const TextStyle(
                  fontSize: 10,
                  color: Color.fromARGB(255, 182, 181, 181),
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    batteryIcon1,
                    width: 48.w,
                    height: 130.h,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Net",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Capacity",
                        style: TextStyle(
                            fontSize:
                                Responsive.isDesktop(context) ? 22.sp : 22,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        power2.toStringAsFixed(1).isEmpty
                            ? "-"
                            : "${power2.toStringAsFixed(1)} kWh",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                color: Colors.black,
                width: 160,
                height: 1,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SOC",
                    style: TextStyle(
                        fontSize: Responsive.isDesktop(context) ? 25.sp : 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    "${bBox1!.sOC ?? 0}%",
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
              const Row(
                children: [
                  Text(
                    "State of charge",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SOH",
                    style: TextStyle(
                        fontSize: Responsive.isDesktop(context) ? 25.sp : 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    "100%",
                    // "${bBox1!.sOH ?? 0}%",
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
              Row(
                children: [
                  Text(
                    "State of health",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: Responsive.isDesktop(context) ? 10.sp : 10,
                        color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
        const VerticalDivider(
          indent: 15,
          endIndent: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, top: 15, right: 15.0, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ConstantText.batteryBox2,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 30),
                  batteryBoxCount == 2
                      ? bBox2?.packCurrent == "0"
                          ? Image.asset(
                              AppImage.batteryOFF,
                              scale: 15,
                            )
                          : Image.asset(
                              AppImage.batteryON,
                              scale: 15,
                            )
                      : const Text(""),
                ],
              ),
              Text(
                batteryBoxCount == 2
                    ? "Capacity: ${model.eb.toString()} kWh"
                    : "Capacity: Null",
                style: const TextStyle(
                  fontSize: 10,
                  color: Color.fromARGB(255, 182, 181, 181),
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    batteryIcon2,
                    width: 48.w,
                    height: 130.h,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Net",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        "Capacity",
                        style: TextStyle(
                            fontSize:
                                Responsive.isDesktop(context) ? 22.sp : 22,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        power2.toStringAsFixed(1).isEmpty
                            ? "-"
                            : "${power2.toStringAsFixed(1)} kWh",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                color: Colors.black,
                width: 160,
                height: 1,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SOC",
                    style: TextStyle(
                        fontSize: Responsive.isDesktop(context) ? 25.sp : 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    "${bBox2?.sOC ?? 0}%",
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
              const Row(
                children: [
                  Text(
                    "State of charge",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SOH",
                    style: TextStyle(
                        fontSize: Responsive.isDesktop(context) ? 25.sp : 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    batteryBoxCount == 2 ? "100%" : "0%",
                    // "${bBox2?.sOH ?? 0}%",
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
              const Row(
                children: [
                  Text(
                    "State of health",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
