import 'package:flutter/material.dart';
import 'package:guin/Home/Model/navalt_general_model.dart';
import 'package:guin/Home/Model/total_co2_trees.dart';
import 'package:guin/Home/View/Widget/custom_card.dart';
import 'package:guin/constants/app_image.dart';
import 'package:guin/constants/app_text.dart';
import 'package:guin/constants/responsive.dart';

class ActivityDetailsCard extends StatelessWidget {
  final Total totalCo2Trees;
  final int boatCount;
  final List<Co2TreeModel> co2TreeModel;
  ActivityDetailsCard(
      {super.key, required this.totalCo2Trees, required this.boatCount})
      : co2TreeModel = [
          Co2TreeModel(
              icon: AppImage.boatIcon,
              value: boatCount.toString(),
              title: AppText.boats),
          Co2TreeModel(
              icon: AppImage.co2Icon,
              value: totalCo2Trees.totalCarbonEmissionSoFar.toString(),
              title: AppText.co2Savings),
          Co2TreeModel(
              icon: AppImage.treesIcon,
              value: totalCo2Trees.treesPlantedSoFar.toString(),
              title: AppText.tressPlanted),
          Co2TreeModel(
              icon: AppImage.dieselIcon,
              value: totalCo2Trees.tlDieselConsumedSoFar.toString(),
              title: AppText.dieselSaving),
          Co2TreeModel(
              icon: AppImage.runHr,
              value: totalCo2Trees.totalRunHrs.toString(),
              title: AppText.runHrs),
        ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: co2TreeModel.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isMobile(context) ? 2 : 5,
          crossAxisSpacing: !Responsive.isMobile(context) ? 15 : 12,
          mainAxisSpacing: 10.0),
      itemBuilder: (context, i) {
        return CustomCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: Image.asset(
                co2TreeModel[i].icon,
                height: 40,
                width: 40,
              )),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 4),
                child: Text(
                  co2TreeModel[i].value,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                co2TreeModel[i].title,
                style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        );
      },
    );
  }
}
