import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitane_frontend/util/const.dart';
import 'package:easy_localization/easy_localization.dart';

class MainLayOutListingWoFB extends StatelessWidget {
  const MainLayOutListingWoFB(
      {Key? key,
      required this.children,
      required this.title,
      this.insteadOfTitle,
      required this.image})
      : super(key: key);
  final List<Widget> children;
  final String image;
  final Widget? insteadOfTitle;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: new PreferredSize(
            preferredSize: tab.preferredSize,
            child: new Card(
              elevation: 26.0,
              color: Colors.white,
              child: tab,
            ),
          ), */
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 90,
            child: Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Constants.primary,
            ))),
        Positioned.fill(
            child: SafeArea(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain,
                      image: AssetImage(
                        image,
                      ))),
              height: 80,
              child: (insteadOfTitle != null)
                  ? insteadOfTitle!
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 0),
                          child: Text(title,
                              style: TextStyle(
                                height: 1.3,
                                color: Colors.white,
                                fontSize: 32,
                              )),
                        )
                      ],
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF8CC63E),
                  borderRadius: BorderRadius.circular(20)),
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 2, right: 2),
              margin: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Decide_ your_ share_ of_ the_ market".tr(),
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "RobotMono",
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: [
                ...children,
              ],
            ))
          ],
        )))
      ]),
    );
  }
}
