import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/shared_preferences.dart';

class OrderModel {
  int id;
  int product;
  int price;
  String payment;
  String status;
  String orderedDate;
  String deliveryDate;
  String address;
  String image;
  String name;
  int quantity;

  OrderModel(
      {this.id,
      this.product,
      this.price,
      this.payment,
      this.status,
      this.orderedDate,
      this.deliveryDate,
      this.address,
      this.image,
      this.name,
      this.quantity});

  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      id: json["id"],
      product: json["product"],
      price: json["total_price"],
      payment: json["payment_method"],
      status: json["delivery_status"],
      orderedDate: json["ordered_date"].split("T")[0],
      deliveryDate: json["delivery_date"].split("T")[0],
      address: json["address"],
      image: API.base + json["product_image"],
      name: json["product_name"],
      quantity: json["quantity"],
    );
  }
}
