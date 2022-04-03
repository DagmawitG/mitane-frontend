import 'package:mitane_frontend/domain/auth/entity/auth_model.dart';
import 'package:mitane_frontend/domain/store/entity/store_model.dart';

class StoreProduct {
  final User user;
  final String id;
  final Map<String, dynamic> location;

  final ProductItem product;

  factory StoreProduct.fromJson(Map<String, dynamic> json) {
    print("Store FromJson $json");
    return StoreProduct(ProductItem.fromJson(json['product']),
        user: User.fromJson(json['user']),
        id: json['id'],
        location: json['location']);
  }

  StoreProduct(this.product,
      {required this.user, required this.id, required this.location});
}

class StoreMachinery {
  final User user;
  final String id;
  final Map<String, dynamic> location;

  final MachineryItem machinery;

  factory StoreMachinery.fromJson(Map<String, dynamic> json) {
    print("Store FromJson $json");
    return StoreMachinery(MachineryItem.fromJson(json['machinery']),
        user: User.fromJson(json['user']),
        id: json['id'],
        location: json['location']);
  }

  StoreMachinery(this.machinery,
      {required this.user, required this.id, required this.location});
}

class StoreIngrident {
  final User user;
  final String id;
  final Map<String, dynamic> location;

  final IngridentItem ingrident;

  factory StoreIngrident.fromJson(Map<String, dynamic> json) {
    print("Store FromJson $json");
    return StoreIngrident(IngridentItem.fromJson(json['ingredient']),
        user: User.fromJson(json['user']),
        id: json['id'],
        location: json['location']);
  }

  StoreIngrident(this.ingrident,
      {required this.user, required this.id, required this.location});
}
