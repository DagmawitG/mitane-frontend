import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/infrastructure/store/repository/store_repository.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresultwobtn.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/selfstoreitemcard.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreMachineryDisplaySelf extends StatefulWidget {
  static const String routeName = '/stores/store/machineryItems';
  final String storeId;
  StoreMachineryDisplaySelf(this.storeId);
  @override
  _StoreMachineryDisplaySelfState createState() =>
      _StoreMachineryDisplaySelfState();
}

class _StoreMachineryDisplaySelfState extends State<StoreMachineryDisplaySelf> {
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
      image: "assets/tractor.png",
      title: "Store_ Machineries".tr(),
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: BlocBuilder<StoreBloc, StoreState>(
                bloc: storeBloc,
                builder: (_, state) {
                  if (state is StoreFetchFailed) {
                    return Center(child: Text('No_ Result_ to_ display'.tr()));
                  }
                  if (state is StoreFetchedById) {
                    final machineryItems = state.store.machineryItems;
                    print("Value of store: ${machineryItems.length}");
                    if (machineryItems.length == 0) {
                      return EmptyResultWBtn(
                        title: "Opps! No Machineries Yet",
                        description:
                            "There are no Machinery items in this store right now.",
                      );
                    }
                    return ListView.builder(
                        itemCount: machineryItems.length,
                        itemBuilder: (_, int index) {
                          final machineryItem = machineryItems[index];
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: SelfStoreItemCard(
                                image: machineryItem.image,
                                id: machineryItem.id!,
                                productName: machineryItem.machinery.name,
                                quantity: machineryItem.quantity.toString(),
                                category: "Machinery",
                                price: machineryItem.pricerPerPiece
                                    .toStringAsFixed(2)),
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
