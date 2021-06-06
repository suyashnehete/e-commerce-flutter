import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/shared_preferences.dart';

class AddressModel {
  String name;
  String phone;
  int id;
  String address;
  String pin;

  AddressModel({this.name, this.phone, this.id, this.address, this.pin});

  factory AddressModel.fromJson(dynamic json) {
    return AddressModel(
      name: json["name"],
      phone: json["phone"],
      id: json["id"],
      address: json["address"],
      pin: json["pin"],
    );
  }
}
