import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guin/Home/Model/all_boat_data.dart';
import 'package:guin/Home/Model/navalt_general_model.dart';
import 'package:guin/Home/View/Widget/custom_card.dart';
import 'package:guin/constants/app_functions.dart';
import 'package:guin/constants/app_image.dart';
import 'package:guin/constants/app_text.dart';
import 'package:guin/constants/constant_values.dart';

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
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 10),
      child: BoatCustomCard(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (kDebugMode) {
                  print("Boat card is clicked>>>>>>>>>>>>>");
                }
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
                            : Colors.white),
                  ),
                ],
              ),
            ),
            CachedNetworkImage(
              imageUrl: modelData.url!,
              height: 50,
              width: 100,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BoatCardValue(
                    imagurl: AppImage.co2Icon,
                    value: co2TreesModel[0].value,
                    title: co2TreesModel[0].title,
                  ),
                  BoatCardValue(
                    // imagurl: navaltDetails[1].icon,
                    imagurl: AppImage.treesIcon,
                    value: co2TreesModel[1].value,
                    title: co2TreesModel[1].title,
                  ),
                  BoatCardValue(
                    imagurl: AppImage.dieselIcon,
                    // imagurl: navaltDetails[2].icon,
                    value: co2TreesModel[2].value,
                    title: co2TreesModel[2].title,
                  ),
                ],
              ),
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
          imagurl!,
          height: 18,
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 4),
          child: Text(
            value.toString(),
            style: const TextStyle(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 10, color: Colors.grey, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
