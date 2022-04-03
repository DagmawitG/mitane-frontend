import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/infrastructure/store/repository/store_repository.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresultwobtn.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/selfstoreitemcard.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreIngredientDisplaySelf extends StatefulWidget {
  static const String routeName = '/stores/store/ingredientItems';
  final String storeId;
  StoreIngredientDisplaySelf(this.storeId);
  @override
  _StoreIngredientDisplaySelfState createState() =>
      _StoreIngredientDisplaySelfState();
}

class _StoreIngredientDisplaySelfState
    extends State<StoreIngredientDisplaySelf> {
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
    //final arguments = ModalRoute.of(context)!.settings.arguments as List;
    return MainLayOutListingWoFB(
      image: "assets/fertlizerC.png",
      title: "Store_ Ingredinets".tr(),
      children: [
        Expanded(child: BlocBuilder<StoreBloc, StoreState>(builder: (_, state) {
          if (state is StoreFetchFailed) {
            return Center(child: Text('No_Result_ to_ display '.tr()));
          }
          if (state is StoreFetchedById) {
            final ingredientItems = state.store.ingredientItems;
            print("Value of store: ${ingredientItems.length}");
            if (ingredientItems.length == 0) {
              return EmptyResultWBtn(
                title: "Opps_ No_ Ingredients_ Yet".tr(),
                description:
                    "There are no Ingredient items in this store right now.",
              );
            }
            return ListView.builder(
                itemCount: ingredientItems.length,
                itemBuilder: (_, int index) {
                  final ingredientItem = ingredientItems[index];
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: SelfStoreItemCard(
                        id: ingredientItem.id!,
                        image: ingredientItem.image,
                        productName: ingredientItem.ingredients.name,
                        quantity: ingredientItem.quantity.toString(),
                        category: "Ingredient",
                        price: ingredientItem.pricerPerKg.toStringAsFixed(2)),
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
