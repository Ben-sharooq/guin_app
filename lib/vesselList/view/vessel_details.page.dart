import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';


import 'package:guin/Home/Controller/homeController.dart';

import 'package:guin/Home/View/Widget/logo_dec_widget.dart';
import 'package:guin/constants/app_image.dart';
import 'package:guin/constants/constants.dart';
import 'package:guin/constants/responsive.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class VesselPage extends StatelessWidget {
  const VesselPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final networkController = Get.find<NetworkController>();
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 15 : 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70),
                    const Center(
                      child: Text(
                        'Boat List',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Obx(() {
                        if (networkController.isBoatdataLoading.value) {
                          return const Center(
                            child: SizedBox(
                              height: 155,
                              child: SpinKitFadingCube(
                                color: Color(0xFF0F0F79),
                                size: 30.0,
                              ),
                            ),
                          );
                        } else if (networkController.navModel.isEmpty) {
                          return const Center(
                            child: Text(
                              "No boats available",
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          );
                        }
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.5,
                          ),
                          itemCount: networkController.navModel.length,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemBuilder: (context, index) {
                            final modelData = networkController.navModel[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      imageUrl: modelData.data!.url!,
                                      description:
                                          "The Alakapuzha is a modern eco-friendly boat designed for sustainable transportation. It can accommodate up to 30 passengers and is powered by a 25 kWh battery, offering a range of 45 km at a maximum speed of 7 knots. Measuring 10 meters in length and 3.5 meters in width, the boat is equipped with optional plug-and-charge functionality for convenience. Its power system includes two 6 kW motors and a 3 kWp solar panel setup, ensuring efficient and sustainable energy usage ${modelData.data!.name}.",
                                      boatname: '${modelData.data!.name}',
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                color: cardBackgroundColor,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        modelData.data!.name!,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 6.0, right: 30),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Location',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 40, left: 40),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Project 261 R5 ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Expanded(
                                      child: Hero(
                                        tag: 'image-${modelData.data!.url!}',
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.vertical(
                                            bottom: Radius.circular(12),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: modelData.data!.url!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 12.0, bottom: 12.0),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.30,
                                        height: 60,
                                        child: PrettyWaveButton(
                                          child: const Text("View more"),
                                          backgroundColor: Colors.blue,
                                          onPressed: () {},
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Custom back button
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back to the previous page
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), // Semi-transparent
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class DetailPage extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String boatname;

  const DetailPage({
    Key? key,
    required this.imageUrl,
    required this.description,
    required this.boatname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Card(
              color: cardBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Text(
                        boatname,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Center(
                        child: Hero(
                          tag: 'image-$imageUrl',
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            LogoDescriptionWidget(
                              logopath: AppImage.lRange,
                            ),
                            LogoDescriptionWidget(
                              logopath: AppImage.lboat,
                            ),
                            LogoDescriptionWidget(logopath: AppImage.location),
                            LogoDescriptionWidget(logopath: AppImage.lsolar),
                            LogoDescriptionWidget(logopath: AppImage.lperson),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        description,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Custom back button
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Navigate back to the previous page
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // Semi-transparent
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
