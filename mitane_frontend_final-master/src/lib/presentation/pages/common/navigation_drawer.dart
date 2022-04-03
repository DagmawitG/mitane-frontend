import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mitane_frontend/application/machinery/bloc/machinery_blocs.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/presentation/pages/agri_inputs/inputs.dart';
import 'package:mitane_frontend/presentation/pages/agri_product/product.dart';
import 'package:mitane_frontend/presentation/pages/farmer/store_display_screen.dart'
    as farmer;
import 'package:mitane_frontend/presentation/pages/machinery/machinery.dart';
import 'package:mitane_frontend/presentation/pages/store/store_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:mitane_frontend/util/const.dart';

final ZoomDrawerController zoomDrawerController = new ZoomDrawerController();

class NaviagationDrawer extends StatelessWidget {
  NaviagationDrawer({Key? key}) : super(key: key);
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Constants.primary,
        ),
        child: Drawer(
          child: new ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => {zoomDrawerController.close!()},
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/mitanelogo.png"))),
                      width: 100,
                      height: 50,
                    ),
                    SizedBox(width: 50)
                  ],
                ),
              ),
              SizedBox(height: 50),
              ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Hello'.tr() + ',\n${currentUser!.name}',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 23,
                      color: const Color(0xffffffff),
                      letterSpacing: -0.0011999999731779098,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 30),
              if (currentUser!.roles[0] != "admin")
                Column(
                  children: [
                    _buildList(
                        onTap: () {
                          zoomDrawerController.close!();
                          switch (currentUser!.roles[0]) {
                            case 'user':
                              Navigator.of(context)
                                  .pushReplacementNamed('/user');
                              break;
                            case 'farmer':
                              Navigator.of(context)
                                  .pushReplacementNamed('/farmer');
                              break;
                            case 'admin':
                              Navigator.of(context)
                                  .pushReplacementNamed('/admin');
                              break;
                            case 'data_encoder':
                              Navigator.of(context)
                                  .pushReplacementNamed('/encoder');
                              break;
                          }
                        },
                        icon: Icons.home,
                        title: "Home".tr()),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Color(0xffffffff),
                      endIndent: 150,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (currentUser!.roles[0] == "user")
                      _buildList(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UHome(),
                              ));
                          zoomDrawerController.close!();
                        },
                        icon: Icons.store,
                        title: "Stores".tr(),
                      ),
                    if (currentUser!.roles[0] == "farmer")
                      _buildList(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => farmer.StoreDisplay(),
                              ));
                          zoomDrawerController.close!();
                        },
                        icon: Icons.store,
                        title: "Stores".tr(),
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Color(0xffffffff),
                      endIndent: 150,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              if (currentUser!.roles[0] == "admin")
                Column(
                  children: [
                    _buildList(
                        onTap: () {
                          BlocProvider.of<MachineryBloc>(context)
                            ..add(MachineryAdminLoad());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminMachineries(),
                              ));
                          zoomDrawerController.close!();
                        },
                        icon: Icons.store,
                        title: "Machineries".tr()),
                    SizedBox(
                      height: 10,
                    ),
                    _buildList(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminIngredients(),
                            ));
                        zoomDrawerController.close!();
                      },
                      icon: Icons.store,
                      title: "የግብርና ንጥረ ነገሮች",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildList(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminProducts(),
                            ));
                        zoomDrawerController.close!();
                      },
                      icon: Icons.store,
                      title: "Agricultural_ Inputs".tr(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildList(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminIngredients(),
                            ));
                        zoomDrawerController.close!();
                      },
                      icon: Icons.store,
                      title: "Agricultural_ Inputs".tr(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildList(
                      onTap: () {
                        BlocProvider.of<MachineryBloc>(context)
                          ..add(MachineryAdminLoad());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminMachineries(),
                            ));
                        zoomDrawerController.close!();
                      },
                      icon: Icons.store,
                      title: "Machineries".tr(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Color(0xffffffff),
                      endIndent: 150,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              _buildList(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text('Terms_ and_ Conditions'.tr()),
                        content: const Text(
                            'ምጣኔ የግብርና ምርቶችን ከአምራች ገበሬው እስከ ሸማች ተጠቃሚ ያለውን የገበያ ሰንሰለት  ለማቀላጠፍ  የሚረዳ መተግበሪያ ነው  እንዲሁም ምርት እና ምርታማነትን ለመጨመር ለማስቻል የሚረዱ የግብርና ግብዓቶችን  እና ማሽነሪዎችን መረጃዎች በቀላሉ ለማግኘት ያስችላል ። በመሆኑም በዚህ አይነተኛ አማራጭ ተጠቅሞ ምርቱን ለመሸጥ የሚፈልግ ማንኛውም ግለሰብም ሆነ ድርጅት ምርቱን ከሸጠ የሸጠበትን አጠቃላይ ዋጋ  ከ2% እስከ 5% ለምጣኔ ድርጅት ኮሚሽን መክፈል እንዳለበት ህግ ያስገድዳል።'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('እሺ'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icons.note,
                  title: "Terms_ and _Conditions".tr()),
              _buildList(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        child: ListView(
                          children: [
                            ListTile(
                              title: Text('Language'.tr()),
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.translate),
                              title: Text('Amharic'),
                              onTap: () async {
                                context.setLocale(Locale("am"));
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.translate),
                              title: Text('English'),
                              onTap: () async {
                                context.setLocale(Locale("en"));
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.translate),
                              title: Text('Oromifa'),
                              onTap: () async {
                                context.setLocale(Locale("om"));
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  icon: Icons.help,
                  title: 'Language'.tr()),
              _buildList(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('ምጣኔ 1.0'),
                        content: Text('polic_y'.tr()),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('እሺ'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icons.help,
                  title: 'About_ Mintane'.tr()),
              _buildList(
                  onTap: () async {
                    await storage.deleteAll();
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName('/welcome'));
                    Navigator.of(context).pushNamed('/welcome');
                  },
                  icon: Icons.logout,
                  title: 'Sign_ out'.tr()),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildList(
      {required Function onTap,
      required String title,
      required IconData icon}) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 0,
      leading: Icon(icon, color: Color(0xffffffff)),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Ubuntu',
          fontSize: 10,
          color: Color(0xffffffff),
          letterSpacing: -0.0007999999821186065,
          fontWeight: FontWeight.w300,
          height: 1.8,
        ),
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        textAlign: TextAlign.left,
      ),
      onTap: () => onTap(),
    );
  }
}
