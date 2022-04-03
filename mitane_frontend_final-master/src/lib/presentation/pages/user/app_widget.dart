import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/presentation/pages/common/navigation_drawer.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenIngredientItems.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenMachineryItems.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenProductItems.dart';

import 'package:mitane_frontend/presentation/pages/priceHub/screens/price_hub_screen.dart';
import 'package:mitane_frontend/util/const.dart';
import 'package:easy_localization/easy_localization.dart';

class UserHome extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<UserHome> {
  List<Widget> pages = [
    StoreProductDisplayAll(),
    StoreIngredientDisplayAll(),
    StoreMachineryDisplayAll(),
    PriceHub()
  ];
  int selectedPage = 0;
  @override
  void initState() {
    super.initState();
    selectedPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      mainScreenScale: .3,
      style: DrawerStyle.Style1,
      showShadow: true,
      menuScreen: NaviagationDrawer(),
      mainScreen: Scaffold(
        appBar: PreferredSize(
          preferredSize: new Size.fromHeight(kBottomNavigationBarHeight + 50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  zoomDrawerController.toggle!();
                                },
                                icon: Icon(
                                  FontAwesomeIcons.hamburger,
                                  size: 25,
                                  color: Colors.white,
                                )),
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/mitanelogo.png"))),
                              width: 100,
                              height: 50,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              BottomNavigationBar(
                elevation: 0,
                onTap: (int index) async {
                  setState(() {
                    selectedPage = index;
                  });
                },
                currentIndex: selectedPage,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey[400],
                backgroundColor: Constants.primary,
                items: [
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.spa,
                        color: Colors.white,
                        size: 16,
                      ),
                      label: "Agricultural_ Products".tr()),
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.handsHelping,
                        color: Colors.white,
                        size: 16,
                      ),
                      label: "Ingredients".tr()),
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.cogs,
                        color: Colors.white,
                        size: 16,
                      ),
                      label: "Machineries".tr()),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.bar_chart,
                      ),
                      label: "Price _Hub".tr()),
                ],
                type: BottomNavigationBarType.fixed,
              ),
            ],
          ),
        ),
        body: pages[selectedPage],
        backgroundColor: Constants.primary,
      ),
    );
  }
}
