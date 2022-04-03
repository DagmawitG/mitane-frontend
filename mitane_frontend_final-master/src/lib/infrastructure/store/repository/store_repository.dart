import 'dart:io';

import 'package:location/location.dart';
import 'package:mitane_frontend/domain/ingredient/entity/ingredient_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';
import 'package:mitane_frontend/domain/product/entity/product_model.dart';
import 'package:mitane_frontend/domain/machinery/entity/machinery_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_product_model.dart';
import 'package:mitane_frontend/infrastructure/store/data_provider/store_provider.dart';

class StoreRepository {
  final StoreProvider storeProvider;
  StoreRepository({required this.storeProvider});

  Future<bool> createStore(double latitude, double longitude) async {
    try {
      return await storeProvider.createStore(latitude, longitude);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<List<Ingredient>> getAllIngredientItems() async {
    return await storeProvider.getAllIngredientItems();
  }

  Future<List<Machinery>> getAllMachineryItems() async {
    return await storeProvider.getAllMachineryItems();
  }

  Future<List<Product>> getAllProductItems() async {
    return await storeProvider.getAllProductItems();
  }

  Future<bool> createProductItem(ProductItem item, File? image) async {
    return await storeProvider.createProductItem(item, image);
  }

  Future<bool> createMachineryItem(MachineryItem item, File? image) async {
    return await storeProvider.createMachineryItem(item, image);
  }

  Future<bool> createIngredientItem(IngridentItem item, File? image) async {
    return await storeProvider.createIngridentItem(item, image);
  }

  Future<Store> getSelfStore() async {
    try {
      final result = await storeProvider.getSelfStore();
      return Store.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductItem>> getSelfProduct() async {
    try {
      final result = await storeProvider.getSelfProduct();
      return result.map((e) => ProductItem.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MachineryItem>> getSelfMachinery() async {
    try {
      final result = await storeProvider.getSelfMachinery();
      return result.map((e) => MachineryItem.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<IngridentItem>> getSelfIngrident() async {
    try {
      final result = await storeProvider.getSelfIngrident();
      return result.map((e) => IngridentItem.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<StoreProduct>> getStoreProducts(String query) async {
    try {
      final result = await storeProvider.getStoreProducts(query);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<StoreIngrident>> getStoreIngridents(String query) async {
    try {
      final result = await storeProvider.getStoreIngridents(query);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<StoreMachinery>> getStoreMachinery(String query) async {
    try {
      final result = await storeProvider.getStoreMachinery(query);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Store> getStoreById(String id) async {
    try {
      final result = await storeProvider.getStoreById(id);
      return Store.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteProductItem(String type, String id) async {
    try {
      final result = await storeProvider.deleteAnItem(type, id);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateStoreItem(String type, String store, String productId,
      String storeitem, double price, int quantity, dynamic image) async {
    try {
      return await storeProvider.updateStoreItem(
          type, store, productId, storeitem, price, quantity, image);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Store>> getAllStore() async {
    try {
      final result = await storeProvider.getAllStores();
      return result.map((e) => Store.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addItem(StoreItem item) async {
    try {
      return true;
    } catch (e) {
      throw Exception();
    }
  }

  Future<dynamic> location() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }
}
