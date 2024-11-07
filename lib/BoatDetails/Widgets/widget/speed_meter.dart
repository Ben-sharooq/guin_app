import 'package:flutter/material.dart';
import 'package:guin/BoatDetails/Model/nav_details.dart';
import 'package:guin/constants/responsive.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedWidget extends StatelessWidget {
  const SpeedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 200,
      child: SizedBox(
        width: 250, height: 200, //height and width of guage
        child: SfRadialGauge(
            enableLoadingAnimation:
                true, //show meter pointer movement while loading
            animationDuration: 4500, //pointer movement speed
            axes: <RadialAxis>[
              //Radial Guage Axix, use other Guage type here
              RadialAxis(
                  radiusFactor: Responsive.isMobile(context)
                      ? 1
                      : Responsive.isTablet(context)
                          ? 1
                          : 1.3,
                  minimum: 0,
                  maximum: 15,
                  ranges: <GaugeRange>[
                    //Guage Ranges
                    GaugeRange(
                        startValue: 0,
                        endValue: 5, //start and end point of range
                        color: Colors.green,
                        startWidth: 10,
                        endWidth: 10),
                    GaugeRange(
                        startValue: 5,
                        endValue: 10,
                        color: Colors.orange,
                        startWidth: 10,
                        endWidth: 10),
                    GaugeRange(
                        startValue: 10,
                        endValue: 15,
                        color: Colors.red,
                        startWidth: 10,
                        endWidth: 10)
                    //add more Guage Range here
                  ],
                  // ignore: prefer_const_literals_to_create_immutables
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: Range.speed,
                    ) //add needlePointer here
                    //set value of pointer to 80, it will point to '80' in guage
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text("${Range.speed} km",
                                style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold))),
                        angle: 90,
                        positionFactor: 0.5),
                    //add more annotations 'texts inside guage' here
                  ])
            ]),
      ),
    );
  }
}
