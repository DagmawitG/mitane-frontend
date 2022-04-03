import 'package:flutter/material.dart';
import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/presentation/pages/common/mitane_button.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/storeproductdetailpage.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/imageheroprivew.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mitane_frontend/util/const.dart';

String buyphone = "25196000000";

class StoreProductCard extends StatelessWidget {
  final String id;
  final User farmer;
  final String storeId;
  final String type;
  final String productName;
  final String price;
  final String quantity;
  final String? category;
  final String? image;
  StoreProductCard(
      {Key? key,
      required this.id,
      required this.type,
      required this.productName,
      required this.price,
      required this.quantity,
      required this.image,
      required this.farmer,
      required this.storeId,
      this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StoreProductDetailPage(
                      type: type,
                      price: price,
                      productId: id,
                      farmer: farmer,
                      productName: productName,
                      qunatity: quantity,
                      storeId: storeId,
                      category: category,
                      image: image,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width / 2) - 30,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (image == null)
                      Container(
                        width: 160,
                        height: 80,
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
                            tag: "hero_someTag_${id}",
                            child: Container(
                              width: 160,
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
                      ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text(
                        "Quantity".tr(),
                        style: TextStyle(fontSize: 14, fontFamily: "RobotMono"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "$quantity",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ]),
                    Wrap(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "ዋጋ በአንድ አሃድ:",
                          style:
                              TextStyle(fontSize: 14, fontFamily: "RobotMono"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "$price" + "ብር",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: (MediaQuery.of(context).size.width / 2) - 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          "$productName",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "RobotMono"),
                        ),
                      ],
                    ),
                    Text(
                      "${category ?? ''}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: "RobotMono"),
                    ),
                    MaterialButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StoreProductDetailPage(
                                    type: type,
                                    price: price,
                                    productId: id,
                                    farmer: farmer,
                                    productName: productName,
                                    qunatity: quantity,
                                    storeId: storeId,
                                    category: category,
                                    image: image,
                                  ))),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Constants.primary,
                            gradient: LinearGradient(
                              begin: Alignment(0.0, -1.0),
                              end: Alignment(0.0, 1.0),
                              colors: [
                                const Color(0xff8CC63E),
                                const Color(0xff709E2F)
                              ],
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff0399DE).withOpacity(.32),
                                  blurRadius: 10,
                                  offset: Offset(0, 8))
                            ]),
                        child: Text(
                          "View Details",
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 14,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
