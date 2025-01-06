import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guin/Home/Controller/homeController.dart';

import 'package:guin/Home/View/dashboard.dart';

import 'package:guin/Login/Model/login_Response.dart';
import 'package:guin/constants/constant_values.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final _dio = Dio();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Future<void> userAuthentication(String username, String password) async {
    isLoading.value = true;

    try {
      final response = await _dio.post(
        "${ConstantText.baseUrl}/login",
        queryParameters: {
          'username': username,
          'password': password,
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        ConstantText.token = loginResponse.accessToken!;
        Get.put(NetworkController());
        Get.snackbar('Success', 'Login successful',
            snackPosition: SnackPosition.BOTTOM);
        Get.off(DashBoard());
      } else {
        Get.snackbar('Error', response.data['detail'] ?? 'Login failed',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error. Please try again later.',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }
}
