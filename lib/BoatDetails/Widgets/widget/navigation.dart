// import 'package:fluro/fluro.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dashboard/model/nav/all_boat_data.dart';
// import 'package:flutter_dashboard/model/nav/nav_details.dart';
// import 'package:flutter_dashboard/routes.dart';
// // Ensure this import points to your WebRouter location

// class MyNavigationWidget extends StatelessWidget {
//   final Data navModelData; // Replace with your actual Data type
//   final double latitude;
//   final double longitude;
//   final List<NavBoatDetailsModel>? snapshotData;

//   MyNavigationWidget({
//     required this.navModelData,
//     required this.latitude,
//     required this.longitude,
//     this.snapshotData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         WebRouter.router.navigateTo(
//           context,
//           '/details',
//           routeSettings: RouteSettings(
//             arguments: {
//               'latitude': latitude,
//               'longitude': longitude,
//               'navModel': navModelData,
//               'snapshotData': snapshotData, // Optional, pass if available
//             },
//           ),
//           transition: TransitionType.fadeIn,
//         );
//       },
//       child:
//           Text("Navigate to DesktopBody"), // Replace with your desired widget
//     );
//   }
// }
