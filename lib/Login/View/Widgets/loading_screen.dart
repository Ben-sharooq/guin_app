import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:guin/constants/constants.dart';

class LoadingScreen extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget child;

  const LoadingScreen({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.7,
    this.color = Colors.grey,
    this.progressIndicator = const CircularProgressIndicator(),
    this.offset,
    this.dismissible = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [child];

    if (inAsyncCall) {
      // Ensure proper layout for progressIndicator
      Widget layOutProgressIndicator = offset == null
          ? const Center(child:  LoadingIcon()) // Centered default loading icon
          : Positioned(
              left: offset!.dx,
              top: offset!.dy,
              child: SizedBox(
                width: 50,
                height:100 ,
                child: progressIndicator,
              ),
            );

      widgetList.addAll([
        // Semi-transparent barrier
        Positioned.fill( // Ensure full coverage of ModalBarrier
          child: Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: dismissible,
              color: color,
            ),
          ),
        ),
        if (offset == null)
          layOutProgressIndicator
        else
          Align(
            alignment: Alignment.center,
            child: layOutProgressIndicator,
          ),
      ]);
    }

    return Stack(
      children: widgetList,
    );
  }
}

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100.0,
      width: 100.0,
      child: SpinKitPulsingGrid(
        color: primaryColor,
        size: 50.0,
      ),
    );
  }
}

