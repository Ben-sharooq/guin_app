import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BoatMapWidget extends StatefulWidget {
  final LatLng latLng;
  const BoatMapWidget({
    super.key,
    required this.latLng,
  });

  @override
  State<BoatMapWidget> createState() => _BoatMapWidgetState();
}

class _BoatMapWidgetState extends State<BoatMapWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  // LatLng boatLatLng =  LatLng(latLng);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GoogleMap(
        // ignore: prefer_collection_literals
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
          ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
          ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
          ..add(Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        compassEnabled: true,
        markers: {
          Marker(markerId: const MarkerId("source"), position: widget.latLng)
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: widget.latLng,
          zoom: 10,
        ),
      ),
    );
  }
}
