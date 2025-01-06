import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:guin/Home/Controller/homeController.dart';
import 'package:guin/constants/app_image.dart';
import 'package:hexcolor/hexcolor.dart';

class WeatherCard extends StatelessWidget {
  final double latitude;
  final double longitude;

  const WeatherCard({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    final weatherController = Get.find<NetworkController>();
    weatherController.getWeatherTemp(latitude,longitude);
// Make a seperate loading state for it #weather
    return Obx(() {
      if (weatherController.isBoatdataLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (weatherController.errorMessage.isNotEmpty) {
        return Center(child: Text(weatherController.errorMessage.value));
      } else if (weatherController.weatherTemp.value != null) {
        final condition = weatherController.weatherTemp.value.weather?[0].id;
        final weatherIcon = getWeatherIcon(condition!);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [
              const Icon(Icons.location_on),
              Text(
                "${weatherController.weatherTemp.value.name ?? 'unknown'}, ${weatherController.weatherTemp.value.sys!.country ?? ''}",
              ),
            ]),
            weatherIcon,
            Text(
              "${weatherController.weatherTemp.value.main!.temp!.round() ?? '--'}°C",
              style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 29),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WeatherItem(
                  text: 'Wind Speed',
                  value: weatherController.weatherTemp.value.wind?.speed?.round()?.toString() ??'--',   
                  unit: 'km/h',
                  imageUrl: AppImage.windSpeed,
                ),
                WeatherItem(
                  text: 'Humidity',
                  value: weatherController.weatherTemp.value.main?.humidity?.toString() ??'--',
                  unit: 'bar',
                  imageUrl: AppImage.humidity,
                ),
              ],
            ),
          ],
        );
      } else {
        return const Center(child: Text("No weather data available"));
      }
    });
  }
}

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    Key? key,
    required this.value,
    required this.text,
    required this.unit,
    required this.imageUrl,
  }) : super(key: key);

  final String value;
  final String text;
  final String unit;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: Color(0xffE0E8FB),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Image.asset(
            imageUrl,
            scale: 4,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value.toString() + unit,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

Widget getWeatherIcon(int condition) {
  if (condition < 300) {
    return const WeatherIcon(path: "assets/weather/lightning.png");
  } else if (condition < 400) {
    return const WeatherIcon(path: "assets/weather/rain.png");
  } else if (condition < 600) {
    return const WeatherIcon(path: "assets/weather/sunny.png");
  } else if (condition < 700) {
    return const WeatherIcon(path: "assets/weather/snow.png");
  } else if (condition < 800) {
    return const WeatherIcon(path: "assets/weather/fog.png");
  } else if (condition == 800) {
    return const WeatherIcon(path: "assets/weather/sun.png");
  } else if (condition <= 804) {
    return const WeatherIcon(path: "assets/weather/cloud.png");
  } else {
    return Image.asset("assets/weather/cloud-lightaning.png");
  }
}

class WeatherIcon extends StatelessWidget {
  final String path;
  // final Color color;
  const WeatherIcon({
    Key? key,
    required this.path,
    // required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      scale: 5,
      color: HexColor("68A4FF"),
    );
  }
}
