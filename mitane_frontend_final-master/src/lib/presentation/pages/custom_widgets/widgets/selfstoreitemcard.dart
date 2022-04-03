import 'package:flutter/material.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/imageheroprivew.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

String buyphone = "25196000000";

class SelfStoreItemCard extends StatelessWidget {
  final String id;
  final String productName;
  final String price;
  final String quantity;
  final String? category;
  final String? image;
  SelfStoreItemCard(
      {Key? key,
      required this.id,
      required this.productName,
      required this.price,
      required this.quantity,
      required this.image,
      this.category})
      : super(key: key);
  void call(String number) => launch("tel:$number");

  void sendSms(String number) => launch("sms:$number");
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 16,
                      color: Color(0x00).withOpacity(.05),
                      offset: Offset(0,
                          10)), //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                  BoxShadow(
                      blurRadius: 18,
                      color: Color(0x00).withOpacity(.075),
                      offset: Offset(0,
                          12)) //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                ],
              ),
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Center(
                      child: Text(
                    'ይዕን ንጥል ለመግዛት በ09000000000 የደውሉ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "RobotMono"),
                  )),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$productName",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "RobotMono"),
                        ),
                        Text(
                          "${category ?? ''}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: "RobotMono"),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "መታወቂያ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "RobotMono"),
                        ),
                        Text(
                          "${id}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: "RobotMono"),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            sendSms(buyphone);
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 8,
                                      color: Color(0xffeeab05).withOpacity(.3),
                                      offset: Offset(0,
                                          5)), //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                                  BoxShadow(
                                      blurRadius: 18,
                                      color: Color(0xffeeab05).withOpacity(.5),
                                      offset: Offset(0,
                                          6)) //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                                ],
                                color: Color(0xffeeab05),
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.textsms,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            call(buyphone);
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 8,
                                      color: Color(0xff04a56d).withOpacity(.3),
                                      offset: Offset(0,
                                          5)), //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                                  BoxShadow(
                                      blurRadius: 18,
                                      color: Color(0xff04a56d).withOpacity(.5),
                                      offset: Offset(0,
                                          6)) //0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23)
                                ],
                                color: Color(0xff04a56d),
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.phone,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$productName",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "RobotMono"),
                        ),
                        Text(
                          "${category ?? ''}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: "RobotMono"),
                        ),
                      ],
                    ),
                  ),
                  if (image == null)
                    Expanded(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/camera.jpg")),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  if (image != null)
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeroPhotoViewRouteWrapper(
                              imageProvider: NetworkImage(image!),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Hero(
                          tag: "hero_someTag",
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("${image}")),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Quantity".tr(),
                          style:
                              TextStyle(fontSize: 16, fontFamily: "RobotMono"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "$quantity",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "ዋጋ በአንድ አሃድ:",
                        style: TextStyle(fontSize: 16, fontFamily: "RobotMono"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "$price" + "ብር",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
