import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:guin/Login/View/login.dart';
import 'package:guin/constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.dark,
              theme: ThemeData(
                primaryColor: MaterialColor(
                  primaryColorCode,
                  <int, Color>{
                    50: const Color(primaryColorCode).withOpacity(0.1),
                    100: const Color(primaryColorCode).withOpacity(0.2),
                    200: const Color(primaryColorCode).withOpacity(0.3),
                    300: const Color(primaryColorCode).withOpacity(0.4),
                    400: const Color(primaryColorCode).withOpacity(0.5),
                    500: const Color(primaryColorCode).withOpacity(0.6),
                    600: const Color(primaryColorCode).withOpacity(0.7),
                    700: const Color(primaryColorCode).withOpacity(0.8),
                    800: const Color(primaryColorCode).withOpacity(0.9),
                    900: const Color(primaryColorCode).withOpacity(1.0),
                  },
                ),
                scaffoldBackgroundColor: const Color(0xFF171821),
                fontFamily: 'IBMPlexSans',
                brightness: Brightness.dark,
              ),
      home:const LoginPage() ,
    );
  }
}

