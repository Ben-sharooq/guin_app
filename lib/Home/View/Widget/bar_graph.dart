
// import 'package:flutter/material.dart';

// import 'package:guin/Home/Model/co2_tress_period_wise.dart';
// import 'package:guin/Home/View/Widget/custom_card.dart';
// import 'package:guin/constants/app_image.dart';
// import 'package:shimmer/shimmer.dart';

// class DieselChart extends StatefulWidget {
//   const DieselChart({super.key});

//   @override
//   State<DieselChart> createState() => _DieselChartState();
// }

// class _DieselChartState extends State<DieselChart> {
//   late TooltipBehavior tooltipBehavior;

//   @override
//   void initState() {
//     super.initState();
//     tooltipBehavior =
//         TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomCard(
//         child: StreamBuilder<TotalCo2TressPeriodWiseModel>(
//             stream: NetworkService().getLiveCo2TreesData(),
//             builder: (context,
//                 AsyncSnapshot<TotalCo2TressPeriodWiseModel> snapshot) {
//               if (snapshot.hasData) {
//                 List<Co2TressChartData> chartData = [];
//                 for (var data in snapshot.data!.data!) {
//                   chartData.add(Co2TressChartData(
//                     x: DateTime.parse(data.reportDatetime!),
//                     y: data.tlDieselConsumed!,
//                   ));
//                 }
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text("Diesel Saved"),
//                     Expanded(
//                       child: SfCartesianChart(
//                         tooltipBehavior: tooltipBehavior,
//                         primaryYAxis: const CategoryAxis(maximumLabels: 5),
//                         primaryXAxis: const CategoryAxis(
//                           isVisible: false,
//                         ),
//                         series: <CartesianSeries<Co2TressChartData, dynamic>>[
//                           ColumnSeries<Co2TressChartData, dynamic>(
//                             dataSource: chartData,
//                             xValueMapper: (Co2TressChartData data, _) => data.x,
//                             yValueMapper: (Co2TressChartData data, _) => data.y,
//                             borderWidth: 1,
//                             width: 1,
//                             color: const Color(0xFF20AEF3),
//                             name: 'Diesel saved',
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               }
//               return Shimmer.fromColors(
//                   baseColor: Colors.grey,
//                   highlightColor: Colors.transparent,
//                   child: Image.asset(
//                     AppImage.shimerChart,
//                     scale: 7,
//                   ));
//             }));
//   }
// }

// class Co2Chart extends StatefulWidget {
//   const Co2Chart({super.key});

//   @override
//   State<Co2Chart> createState() => _Co2ChartState();
// }

// class _Co2ChartState extends State<Co2Chart> {
//   late TooltipBehavior tooltipBehavior;

//   @override
//   void initState() {
//     super.initState();
//     tooltipBehavior =
//         TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomCard(
//       child: StreamBuilder<TotalCo2TressPeriodWiseModel>(
//         stream: NetworkService().getLiveCo2TreesData(),
//         builder:
//             (context, AsyncSnapshot<TotalCo2TressPeriodWiseModel> snapshot) {
//           if (snapshot.hasData) {
//             List<Co2TressChartData> chartData = [];
//             for (var data in snapshot.data!.data!) {
//               chartData.add(Co2TressChartData(
//                 x: DateTime.parse(data.reportDatetime!),
//                 y: data.totalCarbonEmission!,
//               ));
//             }
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("CO\u2082 reduced"),
//                 Expanded(
//                   child: SfCartesianChart(
//                     tooltipBehavior: tooltipBehavior,
//                     // primaryYAxis:
//                     // NumericAxis(isVisible: true, interval: 0.0),
//                     primaryXAxis: const CategoryAxis(isVisible: false),
//                     series: <CartesianSeries<Co2TressChartData, dynamic>>[
//                       ColumnSeries<Co2TressChartData, dynamic>(
//                         dataSource: chartData,
//                         xValueMapper: (Co2TressChartData data, _) => data.x,
//                         yValueMapper: (Co2TressChartData data, _) => data.y,
//                         borderWidth: 1,
//                         width: 1,
//                         color: const Color(0xFFFEB95A),
//                         name: 'CO\u2082 reduced',
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }
//           return Shimmer.fromColors(
//               baseColor: Colors.grey,
//               highlightColor: Colors.transparent,
//               child: Image.asset(
//                 AppImage.shimerChart,
//                 scale: 7,
//               ));
//         },
//       ),
//     );
//   }
// }

// class TressChart extends StatefulWidget {
//   const TressChart({super.key});

//   @override
//   State<TressChart> createState() => _TressChartState();
// }

// class _TressChartState extends State<TressChart> {
//   late TooltipBehavior tooltipBehavior;

//   @override
//   void initState() {
//     super.initState();
//     tooltipBehavior =
//         TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomCard(
//         child: StreamBuilder<TotalCo2TressPeriodWiseModel>(
//             stream: NetworkService().getLiveCo2TreesData(),
//             builder: (context,
//                 AsyncSnapshot<TotalCo2TressPeriodWiseModel> snapshot) {
//               if (snapshot.hasData) {
//                 List<Co2TressChartData> chartData = [];
//                 for (var data in snapshot.data!.data!) {
//                   chartData.add(Co2TressChartData(
//                     x: DateTime.parse(data.reportDatetime!),
//                     y: data.tressPlanted!,
//                   ));
//                 }
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text("Trees Planed "),
//                     Expanded(
//                       child: SfCartesianChart(
//                         tooltipBehavior: tooltipBehavior,
//                         primaryXAxis: const CategoryAxis(isVisible: false),
//                         series: <CartesianSeries<Co2TressChartData, dynamic>>[
//                           ColumnSeries<Co2TressChartData, dynamic>(
//                             dataSource: chartData,
//                             xValueMapper: (Co2TressChartData data, _) => data.x,
//                             yValueMapper: (Co2TressChartData data, _) => data.y,
//                             borderWidth: 1,
//                             width: 1,
//                             color: const Color(0xFFF2C8ED),
//                             name: 'Trees Planed',
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               }
//               return Shimmer.fromColors(
//                   baseColor: Colors.grey,
//                   highlightColor: Colors.transparent,
//                   child: Image.asset(
//                     AppImage.shimerChart,
//                     scale: 7,
//                   ));
//             }));
//   }
// }
