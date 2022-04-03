import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlist.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresult.dart';
import 'package:mitane_frontend/presentation/pages/trader/machineryItems/store_add_machinary_screen.dart';
import 'package:mitane_frontend/presentation/pages/trader/machineryItems/store_machinary_edit_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class TraderStoreMachineryDisplay extends StatefulWidget {
  static const String routeName = '/trader/store/machineries';

  @override
  _TraderStoreMachineryDisplayState createState() =>
      _TraderStoreMachineryDisplayState();
}

class _TraderStoreMachineryDisplayState
    extends State<TraderStoreMachineryDisplay> {
  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(FetchStore(FETCHITEM.MACHINERY));
  }

  Widget slideRightBackground() {
    return Container(
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 40,
            ),
            Icon(
              Icons.align_horizontal_right_rounded,
              color: Colors.green,
              size: 30,
            ),
            Icon(
              Icons.edit,
              color: Colors.green,
              size: 30,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
            Icon(
              Icons.align_horizontal_left_rounded,
              color: Colors.red,
              size: 30,
            ),
            SizedBox(
              width: 40,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayOutListing(
      image: "assets/tractor.png",
      title: "Machineries".tr(),
      children: [
        BlocListener<StoreBloc, StoreState>(
          listener: (context, state) {
            if (state is StoreItemAddFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error_ occured _while_ trying _to _add_ product".tr())));
            }
            if (state is StoreItemDelete) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/trader", (route) => false);
            }
            if (state is StoreCreated) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/trader", (route) => false);
            }
          },
          child: Container(),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Color(0xFF8CC63E),
              borderRadius: BorderRadius.circular(20)),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 2, right: 2),
          margin: EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Decide your share of the market!",
                style: TextStyle(
                    fontSize: 20, fontFamily: "RobotMono", color: Colors.white),
              ),
              Text(
                "Date will be displayed here",
                style: TextStyle(
                    fontSize: 10, fontFamily: "RobotMono", color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(child: BlocBuilder<StoreBloc, StoreState>(builder: (_, state) {
          if (state is StoreFetchFailed) {
            return Center(child: Text('No_ Result_ to_ display'.tr()));
          }
          if (state is NoStoreFound) {
            return EmptyResult(
              title: "Opps_No_ Store_ Yet".tr(),
              description: "You_ don't_ have_ a_ Store_ right_ now_ you_ can_ create_ a_ Store_ below".tr(),
              btntxt: 'Create Store',
              onTap: () => context.read<StoreBloc>().add(CreateStoreFirst()),
            );
          }
          if (state is StoreFetched) {
            final productItems = state.stores.machineryItems;
            print("Value of store: ${productItems.length}");
            if (productItems.length == 0) {
              return EmptyResult(
                title: "pps_No_ Machinery_ Yet".tr(),
                description: "You_ don't_ have_ a_ Machinery_ item_ in_ your_ store_ right_ now_ you_ can_ create_ a_ Machinery_ below".tr(),
                btntxt: 'Create_ Machinery'.tr(),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TraderStoreMachineryAdd())),
              );
            }
            return ListView.builder(
                itemCount: productItems.length,
                itemBuilder: (_, int index) {
                  final productItem = productItems[index];
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Dismissible(
                        child: StoreItemCard(
                            productName: productItem.machinery.name,
                            quantity: productItem.quantity.toString(),
                            category: "Machinery",
                            price:
                                productItem.pricerPerPiece.toStringAsFixed(2)),
                        background: slideRightBackground(),
                        secondaryBackground: slideLeftBackground(),
                        key: ValueKey<Machinery>(productItem.machinery),
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            final bool res = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(
                                        "Are_ you_ sure_ you_ want_ to_ delete".tr() + "${productItem.machinery.name}?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          "Cancel".tr(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          "Delete".tr(),
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            BlocProvider.of<StoreBloc>(context)
                                                .add(DeleteStoreItem(
                                                    'machinery',
                                                    productItem.id!));
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                });
                            return res;
                          } else if (direction == DismissDirection.startToEnd) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TraderStoreMachineryEdit(
                                    storeId: state.stores.id,
                                    machineryItem:
                                        productItems.elementAt(index))));
                          }
                        }),
                  );
                });
          }
          return Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.black26,
              ),
            ),
          );
        })),
      ],
      create: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TraderStoreMachineryAdd())),
    );
  }
}

class StoreItemCard extends StatelessWidget {
  final String productName;
  final String price;
  final String quantity;
  final String? category;
  StoreItemCard(
      {Key? key,
      required this.productName,
      required this.price,
      required this.quantity,
      this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    width: 5))),
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Quantity".tr(),
                        style: TextStyle(fontSize: 16, fontFamily: "RobotMono"),
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
                      "Price_ per_ unit".tr(),
                      style: TextStyle(fontSize: 16, fontFamily: "RobotMono"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "$price birr",
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
    );
  }
}
