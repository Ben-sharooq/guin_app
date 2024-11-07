import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guin/BoatDetails/Model/nav_details.dart';
import 'package:guin/BoatDetails/Widgets/widget/battery_box.dart';
import 'package:guin/BoatDetails/Widgets/widget/boat_location.dart';
import 'package:guin/BoatDetails/Widgets/widget/current_status.dart';
import 'package:guin/BoatDetails/Widgets/widget/speed_meter.dart';
import 'package:guin/BoatDetails/Widgets/widget/weather.dart';
import 'package:guin/Home/Model/all_boat_data.dart';
import 'package:guin/constants/app_image.dart';
import 'package:guin/constants/app_text.dart';
import 'package:guin/constants/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:guin/BoatDetails/View/tablet_view.dart';




class MobileBody extends StatelessWidget {
  final double latitude;
  final double longitude;
  final Data navmodel;
  final List<NavBoatDetailsModel>? snapshotData;

  const MobileBody({
    Key? key,
    required this.navmodel,
    required this.latitude,
    required this.longitude,
    this.snapshotData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LatLng boatLatLng = LatLng(latitude, longitude);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            // Youtube video container
            Container(
              margin: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.7,
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
                      navmodel.name ?? 'Boat Name',  // Handle potential null values safely
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: "${navmodel.url}",
                      height: 250,
                      width: 200,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Co2TreesCard(
                          imagurl: AppImage.co2Icon,
                          value: navmodel.totalCarbonEmission,
                          title: AppText.co2Savings),
                      Co2TreesCard(
                          imagurl: AppImage.treesIcon,
                          value: navmodel.treesPlanted,
                          title: AppText.tressPlanted),
                      Co2TreesCard(
                          imagurl: AppImage.dieselIcon,
                          value: navmodel.tlDieselConsumed,
                          title: AppText.dieselSaving),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularPercentIndicator(
                        radius: 35,
                        lineWidth: 4.0,
                        percent: 0.10,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Range",
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              "${Range.range} km", // Ensure Range.range is correctly defined
                              style: const TextStyle(fontSize: 11),
                            )
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Cost/kW",
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
                  const SpeedWidget(),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                child: snapshotData != null && snapshotData!.length == 2
                    ? CurrentStatus(
                        model: navmodel,
                        bBox1: snapshotData![0].bBox1!,
                        bBox2: snapshotData![1].bBox2!,
                        batteryBoxCount: 2,
                      )
                    : CurrentStatus(
                        model: navmodel,
                        bBox1: snapshotData != null ? snapshotData![0].bBox1! : null,
                        batteryBoxCount: 1,
                      ),
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.46,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: WeatherCard(
                latitude: latitude,
              longitude: longitude,
              ),
            ),

            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: BoatMapWidget(latLng: boatLatLng),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: snapshotData != null && snapshotData!.length == 2
                  ? BatteryListData(
                      snapshotData: snapshotData,
                      bBox1: snapshotData![0].bBox1,
                      bBox2: snapshotData![1].bBox2,
                    )
                  : BatteryListData(
                      bBox1: snapshotData != null ? snapshotData![0].bBox1 : null,
                      snapshotData: [],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}