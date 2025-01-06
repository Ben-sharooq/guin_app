import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:guin/BoatDetails/View/DetailsScreen/NavDetailsScreen.dart';
import 'package:guin/Home/Model/all_boat_data.dart';
import 'package:guin/Home/Model/navalt_general_model.dart';
import 'package:guin/Home/View/Widget/custom_card.dart';
import 'package:guin/constants/app_functions.dart';
import 'package:guin/constants/app_image.dart';
import 'package:guin/constants/app_text.dart';

import '../../Controller/homeController.dart';

class BoatCard extends StatelessWidget {
  final Data modelData;

  const BoatCard({
    super.key,
    required this.modelData,
  });

  List<Co2TreeModel> get co2TreesModel {
    return [
      Co2TreeModel(
          icon: AppImage.co2Icon,
          value: roundNumber(modelData.totalCarbonEmission!, 2),
          title: AppText.co2Savings),
      Co2TreeModel(
          icon: AppImage.treesIcon,
          value: roundNumber(modelData.treesPlanted!, 2),
          title: AppText.tressPlanted),
      Co2TreeModel(
          icon: AppImage.dieselIcon,
          value: roundNumber(modelData.tlDieselConsumed!, 2),
          title: AppText.dieselSaving),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NetworkController>();

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 10),
      child: BoatCustomCard(
        child: Column(
          children: [
            Material(
              // Added Material widget for InkWell support
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  controller.fetchBoatDetails(modelData);
                  if (kDebugMode) {
                    print(
                        '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>boatcard clicked');
                  }

                  Get.to(NavBoatDetailsScreen(modelData: modelData));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(modelData.name!),
                    const Text("  -   "),
                    Text(
                      modelData.boatStatus.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: modelData.boatStatus == "Running"
                            ? Colors.blue
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CachedNetworkImage(
              imageUrl: modelData.url?? '',
              fit: BoxFit.cover,
              height: 60,
              width: 100,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BoatCardValue(
                  imagurl: AppImage.co2Icon,
                  value: co2TreesModel[0].value,
                  title: co2TreesModel[0].title,
                ),
                BoatCardValue(
                  imagurl: AppImage.treesIcon,
                  value: co2TreesModel[1].value,
                  title: co2TreesModel[1].title,
                ),
                BoatCardValue(
                  imagurl: AppImage.dieselIcon,
                  value: co2TreesModel[2].value,
                  title: co2TreesModel[2].title,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BoatCardValue extends StatelessWidget {
  final String? imagurl;
  final dynamic value;
  final String title;

  const BoatCardValue({
    super.key,
    this.imagurl,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagurl ?? '', // Ensure imagurl is not null
          height: 14,
          width: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 4),
          child: Text(
            value.toString(),
            style: const TextStyle(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 8, color: Colors.grey, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
