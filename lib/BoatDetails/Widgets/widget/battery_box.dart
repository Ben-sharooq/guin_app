// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'package:guin/Home/Controller/boat_details_model2.dart';

import 'package:guin/constants/constants.dart';
import 'package:guin/constants/responsive.dart';

class BatteryListData extends StatefulWidget {
  final List<NavBoatDetailsModel2>? snapshotData;

  final BatteryBox? bBox1;
  final BatteryBox? bBox2;
  const BatteryListData({
    Key? key,
    required this.snapshotData,
    this.bBox1,
    this.bBox2,
  }) : super(key: key);

  // final List<NavBatteryBoxDetails> navBatteryBoxDetails;

  @override
  State<BatteryListData> createState() => _BatteryListDataState();
}

class _BatteryListDataState extends State<BatteryListData> {
  List<NavBatteryBoxDetails> navBatteryBoxDetails = <NavBatteryBoxDetails>[];

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      print('bBox1: ${widget.bBox1}');
      print('bBox2: ${widget.bBox2}');
    }
    // Initialize navBatteryBoxDetails with data from bBox1 and bBox2, with fallback values if null.
    navBatteryBoxDetails = <NavBatteryBoxDetails>[
      NavBatteryBoxDetails(
        title: "",
        bBox1: widget.bBox1?.toString() ?? "No data", // Handle null for bBox1
        bBox2: widget.bBox2?.toString() ?? "No data", // Handle null for bBox2
      ),
      NavBatteryBoxDetails(
        title: "Pack current",
        bBox1: widget.bBox1?.packCurrent.toString() ??
            "N/A", // Fallback for packCurrent
        bBox2: widget.bBox2?.packCurrent.toString() ??
            "N/A", // Fallback for packCurrent
      ),
      NavBatteryBoxDetails(
        title: "SOC",
        bBox1: widget.bBox1?.soc.toString() ?? "No data", // Handle null for SOC
        bBox2: widget.bBox2?.soc.toString() ?? "No data", // Handle null for SOC
      ),
      NavBatteryBoxDetails(
        title: "Max cell voltage",
        bBox1: widget.bBox1?.maxCellVoltage.toString() ?? "No data",
        bBox2: widget.bBox2?.maxCellVoltage.toString() ?? "No data",
      ),
      NavBatteryBoxDetails(
        title: "Min cell voltage",
        bBox1: widget.bBox1?.minCellVoltage.toString() ?? "No data",
        bBox2: widget.bBox2?.minCellVoltage.toString() ?? "No data",
      ),
      NavBatteryBoxDetails(
        title: "CMU Vmax cell",
        bBox1: widget.bBox1?.cmuVmaxCell.toString() ?? "No data",
        bBox2: widget.bBox2?.cmuVmaxCell.toString() ?? "No data",
      ),
      NavBatteryBoxDetails(
        title: "CMU Vmin cell",
        bBox1: widget.bBox1?.cmuVminCell.toString() ?? "No data",
        bBox2: widget.bBox2?.cmuVminCell.toString() ?? "No data",
      ),
      NavBatteryBoxDetails(
        title: "Min cell temp",
        bBox1: widget.bBox1?.minCellTempCMU.toString() ?? "No data",
        bBox2: widget.bBox2?.minCellTempCMU.toString() ?? "No data",
      ),
      NavBatteryBoxDetails(
        title: "Max cell temp",
        bBox1: widget.bBox1?.maxCellTempCMU.toString() ?? "No data",
        bBox2: widget.bBox2?.maxCellTempCMU.toString() ?? "No data",
      ),
      NavBatteryBoxDetails(
        title: "Speed",
        bBox1: widget.bBox1?.speed.toString() ?? "No data",
        bBox2: widget.bBox2?.speed.toString() ?? "No data",
      ),
      NavBatteryBoxDetails(
        title: "Max cell(V) no",
        bBox1: widget.bBox1?.maxCellVoltageNo.toString() ?? "No data",
        bBox2: widget.bBox2?.maxCellVoltageNo.toString() ?? "No data",
      ),
      NavBatteryBoxDetails(
        title: "Min cell(V) no",
        bBox1: widget.bBox1?.minCellVoltageNo.toString() ?? "No data",
        bBox2: widget.bBox2?.minCellVoltageNo.toString() ?? "No data",
      ),
      NavBatteryBoxDetails(
        title: "Pack voltage",
        bBox1: widget.bBox1?.packVoltage.toString() ?? "No data",
        bBox2: widget.bBox2?.packVoltage.toString() ?? "No data",
      ),
      NavBatteryBoxDetails(
        title: "SOH",
        bBox1: widget.bBox1?.soh.toString() ?? "No data",
        bBox2: widget.bBox2?.soh.toString() ?? "No data",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isMobile(context)
          ? MediaQuery.of(context).size.height * 1.23
          : MediaQuery.of(context).size.height * 1.2,
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Column(
        children:[ Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.vertical,
            itemCount: navBatteryBoxDetails.length,
            itemBuilder: (context, index) {
              return NavBatteryBoxCard(
                navBatteryBoxDetails: navBatteryBoxDetails[index],
              );
            },
          ),
        ),],
      ),
    );
  }
}

class NavBatteryBoxCard extends StatelessWidget {
  const NavBatteryBoxCard({
    super.key,
    required this.navBatteryBoxDetails,
  });
  final NavBatteryBoxDetails navBatteryBoxDetails;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Responsive.isTablet(context)
          ? const EdgeInsets.all(4)
          : Responsive.isDesktop(context)
              ? const EdgeInsets.all(5)
              : const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          // color: Colors.white70,
        ),
        padding: Responsive.isTablet(context)
            ? const EdgeInsets.all(7)
            : Responsive.isDesktop(context)
                ? const EdgeInsets.all(7)
                : const EdgeInsets.all(10),
        child: Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                navBatteryBoxDetails.title,
                style: TextStyle(
                    fontSize: Responsive.isTablet(context) ? 16 : 15,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    navBatteryBoxDetails.bBox1.toString(),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 115, 115, 243),
                        fontSize: Responsive.isTablet(context) ? 16 : 15,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  
                  Container(
                    padding: Responsive.isDesktop(context)
                        ? const EdgeInsets.all(6)
                        : const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(3, 161, 104, 0.1)),
                    child: Text(
                      navBatteryBoxDetails.bBox2.toString(),
                      style: TextStyle(
                          fontSize: Responsive.isTablet(context) ? 16 : 15,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NavBatteryBoxDetails {
  final String title;
  final String bBox1;
  final String bBox2;

  NavBatteryBoxDetails({
    required this.title,
    required this.bBox1,
    required this.bBox2,
  });
}
