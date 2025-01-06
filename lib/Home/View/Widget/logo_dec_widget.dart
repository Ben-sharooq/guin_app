import 'package:flutter/material.dart';

class LogoDescriptionWidget extends StatelessWidget {
  final String logopath;
  // final String description;
  final double logoHeight;
  final TextAlign textAlign;
  const LogoDescriptionWidget(
      {Key? key,
      required this.logopath,
      // required this.description,
      this.logoHeight = 50,
      this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(logopath,height: logoHeight,),
        // Text(description,textAlign: textAlign,)
      ],
    );
  }
}
