import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:guin/AMC/view/amc_boats.dart';

import 'package:guin/DatabasePage/view/databasepage.dart';

import 'package:guin/Home/Model/menu_modal.dart';

import 'package:guin/Login/View/login.dart';
import 'package:guin/constants/responsive.dart';
import 'package:guin/vesselList/view/vessel_details.page.dart';

class Menu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Menu({
    super.key,
    required this.scaffoldKey,
  });

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuModel> menu = [
    MenuModel(icon: 'assets/svg/home.svg', title: "Dashboard"),
    MenuModel(icon: 'assets/svg/home.svg', title: "Vessels Details"),
    // MenuModel(icon: 'assets/svg/profile.svg', title: "Profile"),
    MenuModel(icon: 'assets/svg/setting.svg', title: "AMC"),
    MenuModel(icon: 'assets/svg/history.svg', title: "Database"),
    MenuModel(icon: 'assets/svg/signout.svg', title: "Sign-out"),
  ];

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.grey[800]!,
              width: 1,
            ),
          ),
          color: const Color(0xFF171821)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: Responsive.isMobile(context) ? 40 : 80,
            ),
            for (var i = 0; i < menu.length; i++)
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                  color: selected == i
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                ),
                child: InkWell(
                  onTap: () {
                    menu.length == 4;

                    setState(() {
                      selected = i;
                    });

                    if (selected == 1) {
                      Get.to(() => const VesselPage());
                    }
                    if (selected == 2) {
                      Get.to(() => AmcBoatListScreen());
                    }
                    if (selected == 3) {
                      Get.to(() => DatabaseTableScreen());
                    }
                    if (selected == 4) {
                      Get.off(() => const LoginPage());
                    }
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 7),
                        child: SvgPicture.asset(
                          menu[i].icon,
                          // ignore: deprecated_member_use
                          color: selected == i ? Colors.black : Colors.grey,
                        ),
                      ),
                      Text(
                        menu[i].title,
                        style: TextStyle(
                            fontSize: 16,
                            color: selected == i ? Colors.black : Colors.grey,
                            fontWeight: selected == i
                                ? FontWeight.w600
                                : FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
          ],
        )),
      ),
    );
  }
}
