import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/infrastructure/store/repository/store_repository.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresultwobtn.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/imageheroprivew.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/selfstoreitemcard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreProductDisplaySelf extends StatefulWidget {
  static const String routeName = '/stores/store/productItems';
  final String storeId;
  StoreProductDisplaySelf(this.storeId);
  @override
  _StoreProductDisplaySelfState createState() =>
      _StoreProductDisplaySelfState();
}

class _StoreProductDisplaySelfState extends State<StoreProductDisplaySelf> {
  late StoreBloc storeBloc =
      new StoreBloc(storeRepository: context.read<StoreRepository>());
  @override
  void initState() {
    final StoreEvent event = FetchStoreById(
      id: widget.storeId,
    );
    storeBloc.add(event);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayOutListingWoFB(
      title: "Store_ Products".tr(),
      image: "assets/productC1.png",
      children: <Widget>[
        Expanded(
            child: BlocBuilder<StoreBloc, StoreState>(
                bloc: storeBloc,
                builder: (_, state) {
                  if (state is StoreFetchFailed) {
                    return Center(child: Text('No_ Result_ to_ display'.tr()));
                  }
                  if (state is StoreFetchedById) {
                    final productItems = state.store.productItems;
                    print("Value of store: ${productItems.length}");
                    if (productItems.length == 0) {
                      return EmptyResultWBtn(
                        title: " Opps_No_ Products_ Yet".tr(),
                        description: "There_ are_ no_ Product_ items_ in_ this_ store_ right_ now".tr(),
                      );
                    }
                    return ListView.builder(
                        itemCount: productItems.length,
                        itemBuilder: (_, int index) {
                          final productItem = productItems[index];
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: SelfStoreItemCard(
                                id: productItem.id!,
                                productName: productItem.product.name,
                                quantity: productItem.quantity.toString(),
                                category: "Product",
                                image: productItem.image,
                                price:
                                    productItem.pricerPerKg.toStringAsFixed(2)),
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
