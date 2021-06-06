import 'package:e_commerce/helper/api_helper.dart';

class CategoryModel {
  String name;
  int price;
  String image;
  int id;

  CategoryModel({this.name, this.price, this.image, this.id});

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
      name: json["name"],
      price: json["price"],
      image: json["image"],
      id: json["id"],
    );
  }
}
