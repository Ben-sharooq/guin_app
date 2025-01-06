// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:guin/Home/Controller/homeController.dart';
// import 'package:guin/Home/View/Widget/custom_card.dart';
// import 'package:guin/constants/responsive.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:toggle_switch/toggle_switch.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class LineChartCard extends StatelessWidget {
//   const LineChartCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final networkController = Get.find<NetworkController>();
//     final int selectIndex;

//     return CustomCard(
//       child: GetBuilder<ChartController>(
//         builder: (controller) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     controller.selectedIndex.value == 0
//                         ? "CO\u2082 reduced"
//                         : controller.selectedIndex.value == 1
//                             ? "Trees Planted"
//                             : "Diesel saved",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   ToggleSwitch(
//                     initialLabelIndex: controller.toggleIndex.value,
//                     minWidth: 50,
//                     minHeight: 30,
//                     totalSwitches: 4,
//                     labels: const ['L', 'D', 'M', 'Y'],
//                     changeOnTap: true,
//                     onToggle: (index) {
//                       controller.changePeriod(index!);
//                       // Fetch new data based on the period
//                       controller.networkService.selectedIndex();
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               AspectRatio(
//                 aspectRatio: Responsive.isMobile(context) ? 9 / 4 : 16 / 6,
//                 child: SfCartesianChart(
//                   tooltipBehavior: TooltipBehavior(enable: true),
//                   primaryYAxis: const NumericAxis(
//                       axisBorderType: AxisBorderType.withoutTopAndBottom,
//                       labelStyle: TextStyle(fontSize: 13)),
//                   primaryXAxis:
//                       CategoryAxis(isVisible: controller.toggleIndex.value > 1),
//                   series: <CartesianSeries>[
//                     (controller.toggleIndex.value <= 1
//                         ? AreaSeries<Co2TressChartData, dynamic>(
//                             dataSource: controller.selectedIndex.value == 0
//                                 ? controller.co2ChartData
//                                 : controller.selectedIndex.value == 1
//                                     ? controller.tressChartData
//                                     : controller.dieselChartData,
//                             xValueMapper: (Co2TressChartData data, _) => data.x,
//                             yValueMapper: (Co2TressChartData data, _) => data.y,
//                             borderWidth: 2,
//                             borderColor: Theme.of(context).primaryColor,
//                             name: controller.selectedIndex.value == 0
//                                 ? "CO\u2082 reduced"
//                                 : controller.selectedIndex.value == 1
//                                     ? "Trees Planted"
//                                     : "Diesel saved",
//                             gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 const Color(0xFF0F0F79),
//                                 const Color(0xFF0F0F79).withOpacity(0.5),
//                                 Colors.transparent,
//                               ],
//                             ),
//                           )
//                         : ColumnSeries<Co2TressChartData, dynamic>(
//                             dataSource: controller.selectedIndex.value == 0
//                                 ? controller.co2ChartData
//                                 : controller.selectedIndex.value == 1
//                                     ? controller.tressChartData
//                                     : controller.dieselChartData,
//                             xValueMapper: (Co2TressChartData data, _) => data.x,
//                             yValueMapper: (Co2TressChartData data, _) => data.y,
//                             borderWidth: 1,
//                             width: 0.05,
//                             borderColor: Theme.of(context).primaryColor,
//                             name: controller.selectedIndex.value == 0
//                                 ? "CO\u2082 reduced"
//                                 : controller.selectedIndex.value == 1
//                                     ? "Trees Planted"
//                                     : "Diesel saved",
//                             gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 const Color(0xFF0F0F79),
//                                 const Color(0xFF0F0F79).withOpacity(0.5),
//                                 Colors.transparent,
//                               ],
//                             ),
//                           ))
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class Co2TressChartData {
//   Co2TressChartData({
//     required this.x,
//     required this.y,
//   });
//   late dynamic x;
//   final double y;
// }

// class ChartController extends GetxController {
//   final networkService = Get.find<NetworkController>();

//   var co2ChartData = <Co2TressChartData>[].obs;
//   var tressChartData = <Co2TressChartData>[].obs;
//   var dieselChartData = <Co2TressChartData>[].obs;

//   var selectedIndex = 0.obs;
//   var toggleIndex = 0.obs;

//   @override
//   void onInit() {
//     fetchChartData();
//     super.onInit();
//   }

//   Future<void> fetchChartData() async {
//     try {
//       var data = await networkService.getDateWiseCo2TreesData(0);
//       co2ChartData.assignAll(data!.co2ChartData);
//       tressChartData.assignAll(data.tressChartData);
//       dieselChartData.assignAll(data.dieselChartData);
//     } catch (e) {}
//   }

//   void changePeriod(int index) {
//     toggleIndex.value = index;
//     update(); // This will refresh the UI if using GetBuilder
//   }
// }
