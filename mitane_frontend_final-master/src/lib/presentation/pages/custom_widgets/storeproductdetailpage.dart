import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_bloc.dart';
import 'package:mitane_frontend/application/store/events/store_events.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/presentation/pages/common/mitane_button.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/imageheroprivew.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenSelfIngredientItems.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenSelfMachineryItems.dart';
import 'package:mitane_frontend/presentation/pages/store/StoreScreenSelfProductItems.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreProductDetailPage extends StatelessWidget {
  final String? image;

  final String productName;
  final String type;

  final String? category;

  final String productId;
  final List<String> callPhones = ["+251 96 633 7163"];

  final String qunatity;

  final String price;
  final User farmer;
  final String storeId;
  StoreProductDetailPage(
      {Key? key,
      this.image,
      required this.farmer,
      required this.storeId,
      required this.productId,
      required this.productName,
      required this.type,
      required this.qunatity,
      required this.price,
      this.category})
      : super(key: key);
  void call(String number) => launch("tel:$number");

  void sendSms(String number) => launch("sms:$number");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe7e9ee),
      body: Container(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.chevron_left,
                      size: 24.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            if (image == null)
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/camera.jpg")),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            if (image != null)
              GestureDetector(
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
                    tag: "hero_someTag_${productId}",
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage("${image}")),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Center(
                child: Text(
              'ይዕን ንጥል ለመግዛት ስር ባሉት ስልክ የደውሉ',
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
                    "Product Name",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "RobotMono"),
                  ),
                  Text(
                    "${productName}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: "RobotMono"),
                  ),
                ],
              ),
            ),
            if (type != "ingrident")
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category",
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
                    "id".tr(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "RobotMono"),
                  ),
                  Text(
                    "${productId}",
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
                    "Product price",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "RobotMono"),
                  ),
                  Text(
                    "${price}",
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
                    "Product Quantity",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "RobotMono"),
                  ),
                  Text(
                    "${qunatity}",
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
                    "Farmer Name",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "RobotMono"),
                  ),
                  Text(
                    "${farmer.name}",
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
                    "Store",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "RobotMono"),
                  ),
                  MitaneButton(
                      onPressed: () {
                        if (type == "product") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  StoreProductDisplaySelf(storeId)));
                        } else if (type == "machinery") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  StoreMachineryDisplaySelf(storeId)));
                        } else if (type == "ingrident") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  StoreIngredientDisplaySelf(storeId)));
                        }
                      },
                      title: "View Store")
                ],
              ),
            ),
            for (String buyphone in callPhones)
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
                    Text(buyphone),
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
      ),
    );
  }
}
