import 'package:flutter/material.dart';
import 'package:guin/Home/View/Home.dart';
import 'package:guin/Home/View/Menu.dart';
import 'package:guin/Home/View/profile.dart';
import 'package:guin/constants/responsive.dart';

class DashBoard extends StatelessWidget {
  final String? page;
  final String? extra;
  DashBoard({Key? key, this.page, this.extra}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 250,
              child: Menu(scaffoldKey: _scaffoldKey),
            )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Profile(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Menu(scaffoldKey: _scaffoldKey),
                ),
              ),
            Expanded(
              flex: 8,
              child: HomePage(scaffoldKey: _scaffoldKey),
            ),
            if (!Responsive.isMobile(context))
              const Expanded(
                flex: 2,
                child: Profile(),
              ),
          ],
        ),
      ),
    );
  }
}

