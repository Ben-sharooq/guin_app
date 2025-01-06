
import 'package:flutter/material.dart';
import 'package:guin/Home/View/Widget/alert_page.dart';
import 'package:guin/constants/constants.dart';
import 'package:guin/constants/responsive.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
          topLeft: Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
        ),
        color: cardBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/images/avatar.png",
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Navalt",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              "Oceans, Electrified",
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: Responsive.isMobile(context) ? 20 : 40,
              
            ),
            const SizedBox(height: 20),
            const Text(
          "Alerts",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
             Expanded(
               child: SingleChildScrollView(
                child: Scheduled()),
             )
           
          ],
        ),
      ),
    );
  }
}
