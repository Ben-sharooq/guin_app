import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:guin/Home/Controller/boatDetailsModel2.dart';
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
  var co2ChartData = <Datum>[].obs;
  var tressChartData = <Datum>[].obs;
  var dieselChartData = <Datum>[].obs;

  var isBoatdataLoading = true.obs; // General loading state
  var isco2dataLoading = true.obs; // Specific loading state for CO2/Trees data
  var isAlertLoading = true.obs;
  var isweatherLoading = true.obs;
  var isPeriodwiseLoading = false.obs;
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
    isBoatdataLoading.value = true;
    const url = "${ConstantText.baseUrl}/api/v1/boats";

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
      isBoatdataLoading.value = false;
    }
  }

  var boatDetails = <NavBoatDetailsModel2>[].obs;
  Future<void> fetchBoatDetails(Data request) async {
    const url = "${ConstantText.baseUrl}/api/v1/data";
    print(request);
    try {
      var data = {
        "name": request.name,
        "b_box": request.bBox,
        "b_box_1_name": request.bBox1Name,
        "b_box_1_value": request.bBox1Value,
        "eb": request.eb,
        "id": request.id,
        "b_box_2_name": request.bBox2Name,
        "b_box_2_value": request.bBox2Value,
        "total_run_hrs": request.totalRunHrs,
        "url": request.url,
        "boat_status": request.boatStatus,
        "tl_diesel_consumed": request.tlDieselConsumed,
        "total_carbon_emission": request.totalCarbonEmission,
        "trees_planted": request.treesPlanted
      };

      var response = await _dio.post(
        url,
        options: Options(headers: getHeaders()),
        data: data,
      );

      if (response.statusCode == 200) {
        var dataList = response.data[0]['data'] as List;
        var rangeInfo = response.data[1]['range'];

        // Check if dataList is populated
        if (dataList.isEmpty) {
          errorMessage.value = 'Data list is empty';
          print('Error: dataList is empty');
          return;
        }

        // Parse BatteryBox items
        var boatDataList = dataList.map((item) {
          var bBoxData = item.values.first as Map<String, dynamic>;
          return BatteryBox.fromJson(bBoxData); // Make sure fromJson exists
        }).toList();

        // Parse rangeInfo to Range1 model
        var range = Range1.fromJson(rangeInfo);

        // Check if parsing was successful
        if (boatDataList.isEmpty || range == null) {
          errorMessage.value = 'Failed to parse boat data or range information';
          print('Error: Failed to parse boat data or range information');
          return;
        }

        // Assign parsed data to boatDetails list
        boatDetails.value = [
          NavBoatDetailsModel2(data: boatDataList, range: range)
        ];

        // Logging to confirm parsed values
        log('Parsed Boat Data List: $boatDataList');
        log('Parsed Range: $range');

        if (boatDetails.isNotEmpty && boatDetails[0].data.isNotEmpty) {
          log('${boatDetails[0].data[0]}');
          if (boatDetails[0].data.length > 1) {
            log('${boatDetails[0].data[1]}');
          }
        }
      } else {
        errorMessage.value = 'Failed to load boat details';
        print('Error: Failed to load boat details');
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
    isco2dataLoading.value = true;
    const url =
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
      isco2dataLoading.value = false;
    }
  }

  // Fetch alerts
  Future<void> fetchAlerts() async {
    isAlertLoading.value = true;
    const url = '${ConstantText.baseUrl}/api/v1/alert';

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
    } finally {
      isAlertLoading.value = false;
    }
  }

  // Fetch weather data based on latitude and longitude
  Future<WeatherTemp?> getWeatherTemp(double lat, double long) async {
    isweatherLoading.value = true;
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
    } finally {
      isweatherLoading.value = false;
    }
    return null;
  }

  // Fetch date-wise CO2 and Trees data
  Future<TotalCo2TressPeriodWiseModel?> getDateWiseCo2TreesData(
      int index) async {
    isPeriodwiseLoading.value = true;
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
    } finally {
      isPeriodwiseLoading.value = false;
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
