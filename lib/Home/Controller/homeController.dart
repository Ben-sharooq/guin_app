import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:guin/BoatDetails/Model/model.dart';
import 'package:guin/BoatDetails/Model/nav_boatdetail_request.dart';
import 'package:guin/Home/Model/alert_model.dart';
import 'package:guin/Home/Model/all_boat_data.dart';
import 'package:guin/Home/Model/co2model.dart';

import 'package:guin/Home/Model/total_co2_trees.dart';
import 'package:guin/Home/Model/weather_temp.dart';
import 'package:guin/constants/app_text.dart';
import 'package:guin/constants/constant_values.dart';

class NetworkController extends GetxController {
  final Dio _dio = Dio();

  var navModel = <NavBoatModelData>[].obs;
  var totalCo2TressData = TotalCo2TressModel().obs;
  var alerts = <Alert>[].obs;
  var selectedIndex = 0.obs;
  var toggleIndex = 0.obs;
  var weatherTemp = WeatherTemp().obs;

  var isLoading = true.obs; // General loading state
  var isLoading1 = true.obs; // Specific loading state for CO2/Trees data
  var errorMessage = ''.obs; // Error message holder

  @override
  void onInit() {
    super.onInit();
    getAllBoatData();
    getTotalCo2TressData();
    fetchAlerts();
    getDateWiseCo2TreesData(0);
  }

  // Function to update selected index
  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  // Fetch all boat data
  Future<void> getAllBoatData() async {
    isLoading.value = true;
    final url = "${ConstantText.baseUrl}/api/v1/boats";

    try {
      var response =
          await _dio.get(url, options: Options(headers: getHeaders()));
      log("$response");

      if (response.statusCode == 200) {
        navModel.value = (response.data as List)
            .map((item) => NavBoatModelData.fromJson(item))
            .toList();
      } else {
        errorMessage.value = 'Failed to load boats';
      }
    } catch (e) {
      errorMessage.value = 'Error in getAllBoatData: $e';
    } finally {
      isLoading.value = false;
    }
  }

  var boatDetails = <BoatData1>[].obs;
  // Fetch specific boat details
  Future<void> fetchBoatDetails(NavBoatDetailsRequest request) async {
    final url = "${ConstantText.baseUrl}/api/v1/data";

    try {
      if (kDebugMode) print('Request Payload: ${request.toJson()}');

      var response = await _dio.post(
        url,
        options: Options(headers: getHeaders()),
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        log('Response Data:${data}');

        // Parse the response to a list of data entries
        var boatDataList = (data['data'] as List).map((item) {
          var bBoxData = item as Map<String, dynamic>;
          return bBoxData
              .map((key, value) => MapEntry(key, parseBatteryBox(value)));
        }).toList();
        boatDetails.value = (response.data['data'] as List)
            .map((item) => BoatData1.fromJson(item))
            .toList();
        // Store or use `boatDataList` as needed in the controller
        log('Parsed Boat Data: $boatDataList');
      } else {
        errorMessage.value = 'Failed to load boat details';
      }
    } catch (e) {
      if (kDebugMode) print('Error fetching boat details: $e');
      errorMessage.value = 'Error in fetchBoatDetails: $e';
    }
  }

  Map<String, dynamic> parseBatteryBox(Map<String, dynamic>? box) {
    if (box == null) return {};

    return {
      "Max_Cell_Voltage": box["Max_Cell_Voltage"],
      "latitude": box["latitude"],
      "longitude": box["longitude"],
      "timestamp": box["timestamp"],
      "speed": box["speed"],
      "port_id": box["port_id"],
      // Add other fields as needed, and handle nulls if required
    };
  }

  // Fetch total CO2 and Trees Data
  Future<void> getTotalCo2TressData() async {
    isLoading1.value = true;
    final url =
        "${ConstantText.baseUrl}/api/v1/total_carbonemission_treesplanted_diesel";

    try {
      var response =
          await _dio.get(url, options: Options(headers: getHeaders()));
      log("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT$response");

      if (response.statusCode == 200) {
        totalCo2TressData.value = TotalCo2TressModel.fromJson(response.data);
      } else {
        errorMessage.value = 'Failed to load CO2 Trees Data';
      }
    } catch (e) {
      errorMessage.value = 'Error in getTotalCo2TressData: $e';
    } finally {
      isLoading1.value = false;
    }
  }

  // Fetch alerts
  Future<void> fetchAlerts() async {
    final url = '${ConstantText.baseUrl}/api/v1/alert';

    try {
      var response =
          await _dio.get(url, options: Options(headers: getHeaders()));

      if (response.statusCode == 200) {
        alerts.value = (response.data as List)
            .map((item) => Alert.fromJson(item))
            .toList();
        log('$response');
      } else {
        errorMessage.value = 'Failed to fetch alerts';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching alerts: $e';
    }
  }

  // Fetch weather data based on latitude and longitude
  Future<WeatherTemp?> getWeatherTemp(double lat, double long) async {
    final url = "https://api.openweathermap.org/data/2.5/weather"
        "?lat=$lat&lon=$long&units=metric&appid=${ConstantText.openWeatherApiToken}";

    try {
      var response = await _dio.get(url);

      if (response.statusCode == 200) {
        weatherTemp.value = WeatherTemp.fromJson(response.data);
        return weatherTemp.value;
      }
    } catch (e) {
      errorMessage.value = 'Error fetching weather data: $e';
    }
    return null;
  }

  // Fetch date-wise CO2 and Trees data
  Future<TotalCo2TressPeriodWiseModel?> getDateWiseCo2TreesData(
      int index) async {
    final url = "${ConstantText.baseUrl}/api/v1/total_carbonemission_graph"
        "?input_param=${AppText.labels![index]}";

    try {
      var response =
          await _dio.post(url, options: Options(headers: getHeaders()));

      if (response.statusCode == 200) {
        return TotalCo2TressPeriodWiseModel.fromJson(response.data);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in getDateWiseCo2TreesData: $e');
      }
    }
    return null;
  }

  // Helper method to get headers
  Map<String, String> getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${ConstantText.token}',
    };
  }
}
