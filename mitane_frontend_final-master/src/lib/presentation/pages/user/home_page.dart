import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';
import 'package:mitane_frontend/presentation/pages/common/mainlayout.dart';
import 'package:mitane_frontend/presentation/pages/store/store_screen_self.dart';
import 'package:easy_localization/easy_localization.dart';

class StoresDisplay extends StatefulWidget {
  static const String routeName = '/stores';

  static Store editArg = Store([], [], [], id: "", location: {}, user: '');

  @override
  _StoresDisplayState createState() {
    return _StoresDisplayState();
  }
}

class _StoresDisplayState extends State<StoresDisplay> {
  @override
  void initState() {
    context.read<StoreBloc>().add(FetchStoreAll());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as String;

    return MainLayOut(
      children: [
        SizedBox(
          height: 10,
        ),
        BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
          if (state is StoreFetchFailed) {
            return Center(child: Text('No_ Result_ to_ display'.tr()));
          }
          if (state is StoreAllFetched) {
            final stores = state.stores;
            return Column(children: [
              for (Store store in stores)
                GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: StoreItemCard(
                        userName: store.user,
                        description: "Tap for details in this store",
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          StoreDisplaySelf.routeName,
                          arguments: [store, arguments]);
                    })
            ]);
          }
          return Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ),
          );
        }),
      ],
    );
  }
}

class StoreItemCard extends StatelessWidget {
  final String userName;
  final String description;
  const StoreItemCard(
      {Key? key, required this.userName, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xDD8CC63E),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Text(
                  "$userName",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: "RobotMono"),
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Flexible(
                child: Text(
                  "$description",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "RobotMono"),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
