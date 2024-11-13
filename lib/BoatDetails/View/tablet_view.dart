import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:guin/BoatDetails/Widgets/widget/battery_box.dart';
import 'package:guin/BoatDetails/Widgets/widget/boat_location.dart';
import 'package:guin/BoatDetails/Widgets/widget/current_status.dart';
import 'package:guin/BoatDetails/Widgets/widget/speed_meter.dart';
import 'package:guin/BoatDetails/Widgets/widget/weather.dart';
import 'package:guin/Home/Controller/boatDetailsModel2.dart';
import 'package:guin/Home/Controller/homeController.dart';
import 'package:guin/Home/Model/all_boat_data.dart';
import 'package:guin/constants/app_image.dart';
import 'package:guin/constants/app_text.dart';
import 'package:guin/constants/constant_values.dart';
import 'package:guin/constants/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TabletBody extends StatefulWidget {
  final double latitude;
  final double longitude;
  final Data navmodel;
  final List<NavBoatDetailsModel2>? snapshotData;
  const TabletBody({
    super.key,
    required this.navmodel,
    required this.latitude,
    required this.longitude,
    this.snapshotData,
  });

  @override
  State<TabletBody> createState() => _TabletBodyState();
}

class _TabletBodyState extends State<TabletBody> {
  @override
  Widget build(BuildContext context) {
    LatLng boatLatLng = LatLng(widget.latitude, widget.longitude);
    final controller = Get.find<NetworkController>();
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            // color: Colors.blue,
            height: MediaQuery.of(context).size.height * 1.03,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First column
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.68,
                          // width: 350,
                          decoration: const BoxDecoration(
                            color: cardBackgroundColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  widget.navmodel.name!,
                                  style: const TextStyle(fontSize: 22),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              Expanded(
                                child: CachedNetworkImage(
                                  width: 200,
                                  imageUrl:
                                      "${ConstantText.baseUrl}${widget.navmodel.url}",
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 25,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Co2TreesCard(
                                      imagurl: AppImage.co2Icon,
                                      value:
                                          widget.navmodel.totalCarbonEmission,
                                      title: AppText.co2Savings),
                                  Co2TreesCard(
                                      imagurl: AppImage.treesIcon,
                                      value: widget.navmodel.treesPlanted,
                                      title: AppText.tressPlanted),
                                  Co2TreesCard(
                                      imagurl: AppImage.dieselIcon,
                                      value: widget.navmodel.tlDieselConsumed,
                                      title: AppText.dieselSaving)
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircularPercentIndicator(
                                    radius: 35,
                                    lineWidth: 4.0,
                                    percent: 0.20,
                                    center: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Range",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          "${controller.boatDetails[0].range} km",
                                          style: const TextStyle(fontSize: 11),
                                        )
                                      ],
                                    ),
                                    progressColor: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  CircularPercentIndicator(
                                    radius: 35,
                                    lineWidth: 4.0,
                                    percent: 0.30,
                                    center: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Cost/kw",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          "0.3",
                                          style: TextStyle(fontSize: 11),
                                        )
                                      ],
                                    ),
                                    progressColor: Colors.green,
                                  ),
                                ],
                              ),
                              const SpeedWidget()
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            // margin: const EdgeInsets.only(top: 15),
                            height: MediaQuery.of(context).size.height * 0.3,
                            // width: 350,
                            decoration: const BoxDecoration(
                              color: cardBackgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            child: BoatMapWidget(latLng: boatLatLng)),
                      ),
                    ],
                  ),
                ),
                //second column
                // third column
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.snapshotData!.length == 2
                        ? BatteryListData(
                            snapshotData: widget.snapshotData,
                            bBox1: controller.boatDetails[0].data[0],
                            bBox2: controller.boatDetails[1].data[1],
                          )
                        : BatteryListData(
                            bBox1: controller.boatDetails[0].data[1],
                            snapshotData: [],
                          ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.snapshotData!.length == 2
                    ? Expanded(
                        flex: 5,
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          height: MediaQuery.sizeOf(context).height * 0.6,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: cardBackgroundColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: CurrentStatus(
                          ),
                        ),
                      )
                    : Container(
                        padding:
                            const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                        height: MediaQuery.sizeOf(context).height * 0.6,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: cardBackgroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: CurrentStatus(
                        ),
                      ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    // margin: const EdgeInsets.only(left: 12),
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: cardBackgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: WeatherCard(
                      latitude: widget.latitude,
                      longitude: widget.longitude,
                    ),
                  ),
                ),
                // Container(
                //     padding:
                //         EdgeInsets.all(Responsive.isTablet(context) ? 4 : 8),
                //     // margin: const EdgeInsets.only(top: 15),
                //     height: MediaQuery.sizeOf(context).height * 0.6,
                //     width: MediaQuery.sizeOf(context).width * 0.33,
                //     decoration: const BoxDecoration(
                //       color: cardBackgroundColor,
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(8.0),
                //       ),
                //     ),
                //     child: BoatMapWidget(latLng: boatLatLng)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Co2TreesCard extends StatelessWidget {
  final String imagurl;
  final dynamic value;
  final String title;
  const Co2TreesCard({
    super.key,
    required this.imagurl,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagurl,
          height: 40,
          width: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 4),
          child: Text(
            value.toString(),
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
