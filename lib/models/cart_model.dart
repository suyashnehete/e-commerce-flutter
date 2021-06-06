import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/shared_preferences.dart';

class CartModel {
  int productId;
  int count;
  int id;
  int price;
  String name;
  String image;

  CartModel(
      {this.productId, this.count, this.id, this.price, this.name, this.image});

  factory CartModel.fromJson(dynamic json) {
    return CartModel(
      productId: json["product"],
      count: json["count"],
      id: json["id"],
      price: json["product_price"],
      name: json["product_name"],
      image: API.base + json["product_image"],
    );
  }
}
