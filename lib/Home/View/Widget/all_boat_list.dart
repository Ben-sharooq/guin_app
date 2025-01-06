// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:guin/BoatDetails/View/DetailsScreen/NavDetailsScreen.dart';
import 'package:guin/Home/Model/all_boat_data.dart';
import 'package:guin/Home/Model/total_co2_trees.dart';

import 'package:guin/constants/responsive.dart';

class AllBoatListWidget extends StatelessWidget {
  final List<NavBoatModelData?> navModelData;

  const AllBoatListWidget({
    super.key,
    required this.navModelData,
    required TotalCo2TressModel totalCo2TressModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
          mainAxisSpacing: Responsive.isMobile(context) ? 50 : 10,
          childAspectRatio: Responsive.isMobile(context) ? 1.5 : 2.0,
          crossAxisSpacing: 20,
        ),
        itemCount: navModelData.length,
        itemBuilder: (context, index) {
          final boatStatus = navModelData[index]!.data!.boatStatus;
          return GestureDetector(
            onTap: () {
              log('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
              Get.to(
                  () => NavBoatDetailsScreen(modelData: navModelData[index]!.data!));
            },
            child: Expanded(
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Column(
                    children: [
                      Flexible(
                          child: Text(
                        navModelData[index]!.data!.name.toString(),
                        overflow: TextOverflow.ellipsis,
                      )),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: navModelData[index]?.data?.url ?? '',
                             // "${ConstantText.baseUrl}${navModelData[index]!.data!.url!}",
                              height: 50,
                              width: 80,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                              ),
                            ),
                            Text("  -  "),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(213, 211, 211, 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                boatStatus.toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: boatStatus == "Running"
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Flexible(
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //         BoatCardValue(
                      //             title: AppText.co2Savings,
                      //             value: roundNumber(
                      //                 navModelData[index]!
                      //                     .data!
                      //                     .totalCarbonEmission!,
                      //                 2)),
                      //         BoatCardValue(
                      //           title: AppText.tressPlanted,
                      //           value: roundNumber(
                      //               navModelData[index]!.data!.treesPlanted!,
                      //               2),
                      //         ),
                      //         BoatCardValue(
                      //           title: AppText.dieselSaving,
                      //           value: roundNumber(
                      //               navModelData[index]!
                      //                   .data!
                      //                   .tlDieselConsumed!,
                      //               2),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const Divider(
                        endIndent: 30,
                        indent: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
