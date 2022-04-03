import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:mitane_frontend/application/store/events/store_events.dart';
import 'package:mitane_frontend/application/store/states/store_state.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_product_model.dart';
import 'package:mitane_frontend/infrastructure/store/repository/store_repository.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository storeRepository;
  StoreBloc({required this.storeRepository}) : super(StoreInit());
  final _picker = ImagePicker();
  File? selectedfile;
  String? editImage;
  Store stores = new Store([], [], [], user: "user", id: "", location: {});
  List<Product>? products;
  List<Machinery>? machineries;
  List<Ingredient>? ingredient;

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    if (event is PickImage) {
      if (event.source == SOURCE.CAMERA) {
        await pickCamera();
        if (selectedfile != null)
          yield ImagePicked(selectedfile!);
        else
          ImagePickedFailed('Image not Picked');
      }
      if (event.source == SOURCE.LIBRARY) {
        await pickLibrary();
        if (selectedfile != null)
          yield ImagePicked(selectedfile!);
        else
          ImagePickedFailed('Image not Picked');
      }
    }
    if (event is CropImage) {
      await cropImage();
      if (selectedfile != null) yield ImagePicked(selectedfile!);
    }
    if (event is ClearImage) {
      clear();
      yield ImagePickedClear();
    }

    if (event is FetchProductStoreSorted) {
      try {
        print("FetchStore called");
        String query = Uri(queryParameters: {
          'sort': event.sort,
          'keyword': event.keyword,
          'categoryName': event.categoryName
        }).query;
        List<StoreProduct> products =
            await storeRepository.getStoreProducts(query);
        print("FetchProductStoreSorted query $query");

        print("Fetch store products ${products.length}");

        yield StoreProductSortedFetched(products);
      } on DioError catch (e) {
        print(e.response);
        if (e.response?.data?['message'] == "User doesn't have a store") {
          yield NoStoreFound();
        }
        rethrow;
        yield StoreFetchFailed();
      }
    }
    if (event is FetchIngridentStoreSorted) {
      try {
        print("FetchStore called");
        String query = Uri(queryParameters: {
          'sort': event.sort,
          'keyword': event.keyword,
          'categoryName': event.categoryName
        }).query;
        List<StoreIngrident> products =
            await storeRepository.getStoreIngridents(query);
        print("FetchProductStoreSorted query $query");

        print("Fetch store products ${products.length}");

        yield StoreIngridentSortedFetched(products);
      } on DioError catch (e) {
        print(e.response);
        if (e.response?.data?['message'] == "User doesn't have a store") {
          yield NoStoreFound();
        }
        rethrow;
        yield StoreFetchFailed();
      }
    }
    if (event is FetchMachineryStoreSorted) {
      try {
        print("FetchStore called");
        String query =
            Uri(queryParameters: {'sort': event.sort, 'keyword': event.keyword})
                .query;
        List<StoreMachinery> products =
            await storeRepository.getStoreMachinery(query);
        print("FetchProductStoreSorted query $query");

        print("Fetch store products ${products.length}");

        yield StoreMachinerySortedFetched(products);
      } on DioError catch (e) {
        print(e.response);
        if (e.response?.data?['message'] == "User doesn't have a store") {
          yield NoStoreFound();
        }
        rethrow;
        yield StoreFetchFailed();
      }
    }
    if (event is FetchStore) {
      try {
        print("FetchStore called");
        stores = await storeRepository.getSelfStore();
        switch (event.item) {
          case FETCHITEM.PRODUCT:
            if (products == null)
              products = await storeRepository.getAllProductItems();
            stores.productItems = await storeRepository.getSelfProduct();
            break;
          case FETCHITEM.MACHINERY:
            machineries = await storeRepository.getAllMachineryItems();
            stores.machineryItems = await storeRepository.getSelfMachinery();

            break;
          case FETCHITEM.INGREDIENT:
            ingredient = await storeRepository.getAllIngredientItems();
            stores.ingredientItems = await storeRepository.getSelfIngrident();
            break;
          default:
        }
        print("Fetch store ${stores.productItems}");

        yield StoreFetched(
            stores: stores,
            products: products ?? [],
            machineries: machineries ?? [],
            ingredients: ingredient ?? []);
      } on DioError catch (e) {
        print(e.response);
        if (e.response?.data?['message'] == "User doesn't have a store") {
          yield NoStoreFound();
        }
        rethrow;
        yield StoreFetchFailed();
      }
    }

    Future<LocationData?> location() async {
      Location location = new Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return null;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }

      _locationData = await location.getLocation();

      return _locationData;
    }

    if (event is CreateStoreFirst) {
      try {
        final LocationData? loc = await location();
        await storeRepository.createStore(
            loc!.latitude ?? 0.0, loc.longitude ?? 0.0);
        yield StoreCreated();
      } catch (e) {
        rethrow;
      }
    }

    if (event is FetchStoreAll) {
      try {
        print("FetchStoreAll called");
        final stores = await storeRepository.getAllStore();
        if (stores != []) {
          yield StoreAllFetched(stores: stores);
        } else
          yield StoreAllFetched(stores: stores);
      } catch (e) {
        rethrow;
        yield StoreFetchFailed();
      }
    }

    if (event is FetchStoreById) {
      try {
        print("FetchStoreAll called");
        final store = await storeRepository.getStoreById(event.id);
        if (store != []) {
          yield StoreFetchedById(store: store);
        } else
          yield StoreFetchedById(store: store);
      } catch (e) {
        rethrow;
        yield StoreFetchFailed();
      }
    }

    if (event is ProductItemCreate) {
      try {
        print("Create product item....");
        yield StoreItemAdding();
        await storeRepository.createProductItem(event.item, selectedfile);
        selectedfile = null;

        /* final stores = await storeRepository.getSelfStore();
        final products = await storeRepository.getAllProductItems();
        final machineries = await storeRepository.getAllMachineryItems();
        // final ingredients = await storeRepository.getAllIngredientItems(); */
        yield StoreItemAdded();
        print("Successfully created product item and listed");
        /* yield StoreFetched(
            stores: stores, products: products, machineries: machineries); */
      } catch (_) {
        yield StoreItemAddFailed();
      }
    }

    if (event is MachineryItemCreate) {
      try {
        yield StoreItemAdding();

        print("Create machinery item....");
        await storeRepository.createMachineryItem(event.item, selectedfile);
        selectedfile = null;
        /* final stores = await storeRepository.getSelfStore();
        final products = await storeRepository.getAllProductItems();
        final machineries = await storeRepository.getAllMachineryItems();
        // final ingredients = await storeRepository.getAllIngredientItems(); */
        yield StoreItemAdded();
        print("Successfully created product item and listed");
        /* yield StoreFetched(
            stores: stores, products: products, machineries: machineries); */
      } catch (_) {
        yield StoreItemAddFailed();
      }
    }

    if (event is IngredientItemCreate) {
      try {
        yield StoreItemAdding();

        print("Create ingredient item....");
        await storeRepository.createIngredientItem(event.item, selectedfile);
        selectedfile = null;

        /* final stores = await storeRepository.getSelfStore();
        final products = await storeRepository.getAllProductItems();
        final machineries = await storeRepository.getAllMachineryItems();
        // final ingredients = await storeRepository.getAllIngredientItems(); */
        yield StoreItemAdded();
        print("Successfully created product item and listed");
        /* yield StoreFetched(
            stores: stores, products: products, machineries: machineries); */
      } catch (_) {
        yield StoreItemAddFailed();
      }
    }

    // if (event is AddStore) {
    //   try {
    //     final storeCheck = await storeRepository.getSelfStore();
    //     if (storeCheck != []) {
    //       print('store exist');
    //       final result = await storeRepository.addItem(event.item);
    //       if (result) {
    //         print("added item");
    //         yield StoreItemAdded();
    //       } else {
    //         yield StoreItemAddFailed();
    //       }
    //     } else {
    //       final creatStore = await storeRepository.createStore();
    //       if (creatStore) {
    //         print('store created');
    //         yield StoreItemAddFailed();
    //       }
    //     }
    //   } catch (e) {
    //     yield StoreItemAddFailed();
    //   }
    // }

    if (event is UpdateStore) {}

    if (event is UpdateStoreItem) {
      try {
        yield StoreItemUpdating();
        print("StoreItemUpdating");
        final storeCheck = await storeRepository.updateStoreItem(
            event.type,
            event.store,
            event.productId,
            event.storeItem,
            event.price,
            event.quantity,
            selectedfile ?? editImage);
        print("storeCheck $storeCheck");
        if (storeCheck) {
          yield StoreItemUpdated();
        } else {
          yield StoreItemUpdatedFailed();
        }
      } catch (e) {
        print(e);
        yield StoreItemDeleteFailed();
      }
    }
    if (event is DeleteStore) {}
    if (event is DeleteStoreItem) {
      try {
        yield StoreItemDeleting();
        print("StoreDeleting");
        final storeCheck =
            await storeRepository.deleteProductItem(event.type, event.item);
        print("storeCheck $storeCheck");
        if (storeCheck) {
          yield StoreItemDelete();
        } else {
          yield StoreItemDeleteFailed();
        }
      } catch (e) {
        print(e);
        yield StoreItemDeleteFailed();
      }
    }
  }

  Future pickCamera() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) selectedfile = File(pickedFile.path);
  }

  Future pickLibrary() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) selectedfile = File(pickedFile.path);
  }

  Future<void> cropImage() async {
    if (selectedfile != null)
      selectedfile = await ImageCropper.cropImage(
        sourcePath: selectedfile!.path,
        maxWidth: 512,
        maxHeight: 512,
      );
  }

  void clear() {
    selectedfile = null;
  }
}
