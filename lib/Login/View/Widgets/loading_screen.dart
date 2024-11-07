//library modal_progress_hud;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///
/// Wrap around any widget that makes an async call to show a modal progress
/// indicator while the async call is in progress.
///
/// The progress indicator can be turned on or off using [inAsyncCall]
///
/// The progress indicator defaults to a [CircularProgressIndicator] but can be
/// any kind of widget
///
/// The progress indicator can be positioned using [offset] otherwise it is
/// centered
///
/// The modal barrier can be dismissed using [dismissible]
///
/// The color of the modal barrier can be set using [color]
///
/// The opacity of the modal barrier can be set using [opacity]
///
/// HUD=Heads Up Display
///
class LoadingScreen extends StatelessWidget {
  final bool? inAsyncCall;
  final double opacity;
  final Color? color;
  final Widget progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget? child;

  const LoadingScreen({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.7,
    this.color = Colors.grey,
    this.progressIndicator = const CircularProgressIndicator(),
    this.offset,
    this.dismissible = false,
    required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child!);
    if (inAsyncCall!) {
      Widget layOutProgressIndicator;
      if (offset == null) {
        layOutProgressIndicator = const LoadingIcon();
      } else {
        layOutProgressIndicator = Positioned(
          left: offset?.dx,
          top: offset?.dy,
          child: progressIndicator,
        );
      }
      final modal = [
        Opacity(
          opacity: opacity,
          child: ModalBarrier(dismissible: dismissible, color: color),
        ),
        layOutProgressIndicator
      ];
      widgetList += modal;
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
    return const Center(
        child: Align(
      alignment: Alignment.center,
      child: SizedBox(
        child: SpinKitPulsingGrid(
          color: Colors.amber,
          //waveColor:AppColors.primaryColor ,
          size: 50.0,
        ),
        // height: 30.0,
        // width: 30.0,
      ),
    ));
  }
}
