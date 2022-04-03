import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mitane_frontend/application/product/bloc/product_blocs.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';
import 'package:mitane_frontend/presentation/pages/store/store_screen_self.dart';
import 'package:easy_localization/easy_localization.dart';

class UHome extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<UHome> {
  @override
  Widget build(BuildContext context) {
    return MainLayOutListingWoFB(
        image: "assets/vector backc.png",
        title: "StoresStores".tr(),
        children: [
          Wrap(spacing: 20, runSpacing: 20.0, children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150.0,
                  height: 160.0,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<ProductBloc>(context)
                        ..add(ProductAdminLoad());
                      Navigator.of(context)
                          .pushNamed('/product', arguments: "user");
                    },
                    child: Card(
                        color: Color(0xDD8CC63E),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.spa,
                                color: Colors.white,
                                size: 80,
                              ),
                              Text(
                                "Agricultural_ Products".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  height: 160.0,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<StoreBloc>(context)..add(FetchStoreAll());

//                         Navigator.of(context).pushNamed('/inputs');

                      Navigator.of(context)
                          .pushNamed('/inputs', arguments: "user");
                    },
                    child: Card(
                        color: Color(0xDD8CC63E),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.handsHelping,
                                color: Colors.white,
                                size: 80,
                              ),
                              Text(
                                "Agricultural_ Inputs".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150.0,
                  height: 160.0,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<StoreBloc>(context)..add(FetchStoreAll());

//                         Navigator.of(context).pushNamed('/machinery');

                      Navigator.of(context)
                          .pushNamed('/machinery', arguments: "user");
                    },
                    child: Card(
                        color: Color(0xDD8CC63E),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.cogs,
                                color: Colors.white,
                                size: 80,
                              ),
                              Text(
                                "Machineries".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            )
          ])
        ]);
  }
}
