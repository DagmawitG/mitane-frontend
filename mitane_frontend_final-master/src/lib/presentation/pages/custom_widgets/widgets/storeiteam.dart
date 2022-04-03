import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreItemCard extends StatelessWidget {
  final String productName;
  final String price;
  final String quantity;
  final String? image;
  final String? category;
  StoreItemCard(
      {Key? key,
      required this.productName,
      required this.price,
      required this.quantity,
      required this.image,
      this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        //height: 90,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "RobotMono"),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "ብዛት:",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: "RobotMono"),
                            ),
                            Text(
                              "$quantity",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ]),
                      Wrap(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price_ per_ unit".tr(),
                            style: TextStyle(
                                fontSize: 12, fontFamily: "RobotMono"),
                          ),
                          Text(
                            "$price",
                            style: TextStyle(fontSize: 14.0),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                if (image == null)
                  Expanded(
                    child: Container(
                      width: 70,
                      height: 70,
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
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage("${image}")),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
