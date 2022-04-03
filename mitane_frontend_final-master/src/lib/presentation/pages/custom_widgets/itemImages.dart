import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitane_frontend/application/store/bloc/store_blocs.dart';
import 'package:easy_localization/easy_localization.dart';

class ItemImagePicture extends StatefulWidget {
  ItemImagePicture({Key? key, this.storeBloc}) : super(key: key);

  final StoreBloc? storeBloc;

  @override
  State<ItemImagePicture> createState() => _ItemImagePictureState();
}

class _ItemImagePictureState extends State<ItemImagePicture> {
  late StoreBloc storeBloc;
  @override
  void initState() {
    storeBloc = widget.storeBloc ?? storeBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
        bloc: storeBloc,
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    color: Color(0xffd6d6d6),
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
                  child: Builder(builder: (context) {
                    if (state is ImagePickedFailed) return Text(state.msg);
                    if (state is ImagePicked)
                      return Container(
                        height: 100,
                        width: 175,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(state.file),
                                fit: BoxFit.cover)),
                      );
                    if (storeBloc.editImage != null)
                      return Container(
                        height: 100,
                        width: 175,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(storeBloc.editImage!))),
                      );
                    return Container(
                      height: 100,
                      width: 175,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/camera.jpg"))),
                    );
                  })),
              Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.photo_camera),
                        onPressed: () {
                          storeBloc.add(PickImage(SOURCE.CAMERA));
                        }),
                    IconButton(
                        icon: Icon(Icons.photo_library),
                        onPressed: () {
                          storeBloc.add(PickImage(SOURCE.LIBRARY));
                        }),
                  ],
                ),
                if (storeBloc.selectedfile != null)
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.crop),
                        onPressed: () => storeBloc.add(CropImage()),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => storeBloc.add(ClearImage()),
                      )
                    ],
                  )
              ]),
            ],
          );
        });
  }
}
