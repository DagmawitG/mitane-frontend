import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mitane_frontend/application/store/bloc/store_bloc.dart';
import 'package:mitane_frontend/application/store/events/store_events.dart';
import 'package:mitane_frontend/application/store/states/store_state.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/presentation/pages/common/farmermainlayoutlist.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresult.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/storeiteam.dart';
import 'package:mitane_frontend/presentation/pages/farmer/machineryItems/store_add_machinary_screen.dart';
import 'package:mitane_frontend/presentation/pages/farmer/machineryItems/store_machinary_edit_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreMachinaryDisplay extends StatefulWidget {
  static const String routeName = '/store/machineries';

  @override
  _StoreMachinaryDisplayState createState() => _StoreMachinaryDisplayState();
}

class _StoreMachinaryDisplayState extends State<StoreMachinaryDisplay> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
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
    return FarerMainLayOutListing(
      image: "assets/tractor.png",
      buttonText: "Create_ Machinery".tr(),
      title: "Store_ Machineries".tr(),
      create: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => StoreMachinaryAdd())),
      children: [
        BlocListener<StoreBloc, StoreState>(
          listener: (context, state) {
            if (state is StoreItemAddFailed) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Error_ occured _while_ trying _to _add_ product".tr())));
            }
            if (state is StoreItemDelete) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/farmer", (route) => false);
            }
            if (state is StoreCreated) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/farmer", (route) => false);
            }
          },
          child: Container(),
        ),
        Expanded(child: BlocBuilder<StoreBloc, StoreState>(builder: (_, state) {
          if (state is StoreFetchFailed) {
            return Center(child: Text('No_ Result_ to_ display'.tr()));
          }
          if (state is NoStoreFound) {
            return EmptyResult(
              title: "Opps_ No_ Store_ Yet".tr(),
              description:
                  "You_ don't_ have_ a_ Store_ right_ now_ you_ can_ create_ a_ Store_ below"
                      .tr(),
              btntxt: 'Create_ Store'.tr(),
              onTap: () => context.read<StoreBloc>().add(CreateStoreFirst()),
            );
          }
          if (state is StoreFetched) {
            final productItems = state.stores.machineryItems;
            print("Value of store: ${productItems.length}");
            if (productItems.length == 0) {
              return EmptyResult(
                title: "Opps_ No_ Store_ Yet".tr(),
                description:
                    "You_ don't_ have_ a_ Machinery_ item_ in_ your_ store_ right_ now_ you_ can_ create_ a_ Machinery_ below"
                        .tr(),
                btntxt: 'Create_ Machinery'.tr(),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StoreMachinaryAdd())),
              );
            }
            return ListView.builder(
                itemCount: productItems.length,
                itemBuilder: (_, int index) {
                  final productItem = productItems[index];
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                    child: Dismissible(
                        child: StoreItemCard(
                            productName: productItem.machinery.name,
                            quantity: productItem.quantity.toString(),
                            category: "machinery".tr(),
                            image: productItem.image,
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
                                        "Are_ you_ sure_ you_ want_ to_ delete_ productItem_ingredients_name"
                                                .tr() +
                                            "${productItem.machinery.name}?"),
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
                                builder: (context) => StoreMachinaryEdit(
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
    );
  }
}
