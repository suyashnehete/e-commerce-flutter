import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/shared_preferences.dart';

class UserModel {
  String name;
  String image;
  String phone;
  String token;
  String email;

  UserModel({this.name, this.token, this.image, this.phone, this.email});

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      name: json["name"],
      image: API.base + json["image"],
      token: json["token"],
      phone: json["phone"].toString(),
      email: json["email"],
    );
  }
}
