import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayoutlistwithourfb.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/emptyresultwobtn.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/selfstoreitemcard.dart';
import 'package:mitane_frontend/presentation/pages/custom_widgets/widgets/storeproductcard.dart';
import 'package:mitane_frontend/util/const.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreMachineryDisplayAll extends StatefulWidget {
  static const String routeName = '/stores/store/machineryItems';

  @override
  _StoreMachineryDisplayAllState createState() =>
      _StoreMachineryDisplayAllState();
}

class _StoreMachineryDisplayAllState extends State<StoreMachineryDisplayAll> {
  String sortValue = 'name';

  @override
  void initState() {
    fetchProduct();
    super.initState();
  }

  void fetchProduct(
      {String? category, String? keyword, List<String> sort = const []}) async {
    String sortString = '';

    for (var i = 0; i < sort.length; i++) {
      if (i == sort.length - 1) {
        sortString += sort[i];
      } else {
        sortString += sort[i] + ',';
      }
    }

    BlocProvider.of<StoreBloc>(context)
        .add(FetchMachineryStoreSorted(keyword: keyword, sort: sortString));
  }

  @override
  Widget build(BuildContext context) {
    //final arguments = ModalRoute.of(context)!.settings.arguments as List;
    return MainLayOutListingWoFB(
      image: "assets/tractor.png",
      title: "Store_ Machineries".tr(),
      insteadOfTitle: Container(
        width: 320,
        // padding: const EdgeInsets.all(10.0),
        //height: 10,

        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff0399DE).withOpacity(.32),
                        blurRadius: 10,
                        offset: Offset(0, 8))
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Machinery...',
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                        child: const Icon(Icons.search)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Sort By: ',
                            style: TextStyle(color: Colors.white)),
                        DropdownButton<String>(
                          value: sortValue,
                          items: [
                            DropdownMenuItem<String>(
                              child: Text('Name ACE'),
                              value: 'name',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Date ACE'),
                              value: 'date',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Quanity ACE'),
                              value: 'quantity',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Price ACE'),
                              value: 'price',
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null)
                              setState(() {
                                sortValue = value;
                              });
                          },
                          hint: Text("Sort By"),
                          disabledHint: Text("Disabled"),
                          elevation: 8,
                          style: TextStyle(color: Colors.green, fontSize: 16),
                          icon: Icon(Icons.arrow_drop_down_circle),
                          iconDisabledColor: Colors.red,
                          iconEnabledColor: Colors.green,
                          iconSize: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(child: BlocBuilder<StoreBloc, StoreState>(builder: (_, state) {
          if (state is StoreFetchFailed) {
            return Center(child: Text('No_ Result_ to_ display'.tr()));
          }
          if (state is StoreMachinerySortedFetched) {
            final machineryItems = state.storeMachinery;
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
                  final productItem = machineryItems[index];
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: StoreProductCard(
                        type: "machinery",
                        storeId: productItem.id,
                        farmer: productItem.user,
                        id: productItem.machinery.id ?? "",
                        productName: productItem.machinery.machinery.name,
                        quantity: productItem.machinery.quantity.toString(),
                        category: '',
                        image: productItem.machinery.image,
                        price: productItem.machinery.pricerPerPiece
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
