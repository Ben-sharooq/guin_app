import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:guin/BoatDetails/Widgets/widget/battery_box.dart';
import 'package:guin/BoatDetails/Widgets/widget/boat_location.dart';
import 'package:guin/BoatDetails/Widgets/widget/current_status.dart';
import 'package:guin/BoatDetails/Widgets/widget/speed_meter.dart';
import 'package:guin/BoatDetails/Widgets/widget/weather.dart';
import 'package:guin/Home/Controller/boat_details_model2.dart';
import 'package:guin/Home/Controller/homeController.dart';
import 'package:guin/Home/Model/all_boat_data.dart';
import 'package:guin/constants/app_image.dart';
import 'package:guin/constants/app_text.dart';

import 'package:guin/constants/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DesktopBody extends StatefulWidget {
  final double latitude;
  final double longitude;
  final Data navmodel;
  final List<NavBoatDetailsModel2>? snapshotData;

  const DesktopBody({
    Key? key,
    required this.navmodel,
    required this.latitude,
    required this.longitude,
    required this.snapshotData,
  }) : super(key: key);

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  @override
  Widget build(BuildContext context) {
    LatLng boatLatLng = LatLng(widget.latitude, widget.longitude);
    final controller = Get.find<NetworkController>();
    return WillPopScope(onWillPop: () async {
      return false;
    },

   child:  Scaffold(
      body: 
      
       Row(
        children: [   
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.navmodel.name ?? '',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: CachedNetworkImage(
                        width: 250,
                        imageUrl: "${widget.navmodel.url}",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Co2TreesCard(
                          imagurl: AppImage.co2Icon,
                          value: widget.navmodel.totalCarbonEmission,
                          title: AppText.co2Savings,
                        ),
                        Co2TreesCard(
                          imagurl: AppImage.treesIcon,
                          value: widget.navmodel.treesPlanted,
                          title: AppText.tressPlanted,
                        ),
                        Co2TreesCard(
                          imagurl: AppImage.dieselIcon,
                          value: widget.navmodel.tlDieselConsumed,
                          title: AppText.dieselSaving,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircularPercentIndicator(
                          radius: 35,
                          lineWidth: 4.0,
                          percent: 0.20,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Range",
                                  style: TextStyle(fontSize: 10)),
                              Text(
                                  "${controller.boatDetails[0].range.range} km",
                                  style: const TextStyle(fontSize: 11)),
                            ],
                          ),
                          progressColor: Colors.red,
                        ),
                        const SizedBox(width: 100),
                        CircularPercentIndicator(
                          radius: 35,
                          lineWidth: 4.0,
                          percent: 0.30,
                          center: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Cost/kw", style: TextStyle(fontSize: 10)),
                              Text("0.3", style: TextStyle(fontSize: 11)),
                            ],
                          ),
                          progressColor: Colors.green,
                        ),
                      ],
                    ),
                    const SpeedWidget(),
                  ],
                ),
              ),
            ),
          ),
          // Second column: Current Status and Weather
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        _buildCurrentStatus(context),
                        const SizedBox(width: 12),
                        _buildWeatherCard(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    flex: 3,
                    child: _buildBoatMap(boatLatLng),
                  ),
                ],
              ),
            ),
          ),
          // Third column: Battery List
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BatteryListData(
                snapshotData: widget.snapshotData ?? [],
                bBox1: controller.boatDetails[0].data[0],
                bBox2: controller.boatDetails.length == 2
                    ? controller.boatDetails[0].data[1]
                    : null,
              ),
            ),
          ),
        ],
      ),
    ),);
  }

  // Helper: Current Status Widget
  Widget _buildCurrentStatus(BuildContext context) {
    bool hasTwoBatteries = widget.snapshotData?.length == 2;
    return Container(
      width: MediaQuery.of(context).size.width * 0.278,
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CurrentStatus(),
      ),
    );
  }

  // Helper: Weather Card Widget
  Widget _buildWeatherCard() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.161,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: WeatherCard(
        latitude: widget.latitude,
        longitude: widget.longitude,
      ),
    );
  }

  // Helper: Boat Map Widget
  Widget _buildBoatMap(LatLng boatLatLng) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: BoatMapWidget(latLng: boatLatLng),
    );
  }
}

// Custom Card for CO2, Trees, and Diesel Information
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
        Image.asset(imagurl, height: 40, width: 40),
        const SizedBox(height: 10),
        Text(
          value.toStringAsFixed(2),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
