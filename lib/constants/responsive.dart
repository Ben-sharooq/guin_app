import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 750;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1230 &&
      MediaQuery.of(context).size.width >= 750;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1230;
}