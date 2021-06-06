import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:e_commerce/helper/shared_preferences.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/address_model.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';

import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/product_highlight_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/product_review_model.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class API {
  static final String base = "http://10.0.2.2:8000";

  static Future<void> getOffers(BuildContext context) async {
    Response response = await get(Uri.parse(base + "/offers"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        Provider.of<Data>(context, listen: false)
            .addOffer(base + data["image"]);
      }
    }
  }

  static Future<void> getTopCategories(BuildContext context) async {
    Response response = await get(Uri.parse(base + "/category/top/"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        data["image"] = API.base + data["image"];
        Provider.of<Data>(context, listen: false)
            .addTopCategory(CategoryModel.fromJson(data));
      }
    }
  }

  static Future<void> getTopProducts(BuildContext context) async {
    Response response = await get(Uri.parse(base + "/product/top/"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        data["image"] = API.base + data["image"];
        Provider.of<Data>(context, listen: false)
            .addTopProduct(ProductModel.fromJson(data));
      }
    }
  }

  static Future<void> getTrendingProducts(BuildContext context) async {
    Response response = await get(Uri.parse(base + "/product/trending/"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        data["image"] = API.base + data["image"];
        Provider.of<Data>(context, listen: false)
            .addTrendingProduct(ProductModel.fromJson(data));
      }
    }
  }

  static Future<List<ProductModel>> getAllProducts(BuildContext context,
      {String query = ""}) async {
    List<ProductModel> lst = [];
    Response response = await get(Uri.parse(base + "/product/$query"),
        headers: {"Authorization": await Auth.getAuthToken()});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        lst.add(ProductModel.fromJson(data));
      }
    }
    return lst;
  }

  static Future<List<CategoryModel>> getAllCategories(
      BuildContext context) async {
    List<CategoryModel> lst = [];
    Response response = await get(Uri.parse(base + "/category/"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        lst.add(CategoryModel.fromJson(data));
      }
    }
    return lst;
  }

  static Future<List<String>> getProductImages(BuildContext context,
      {int id}) async {
    List<String> lst = [];
    Response response = await get(Uri.parse(base + "/product/images/$id"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        lst.add(base + data["image"]);
      }
    }
    return lst;
  }

  static Future<List<ProductHighlightModel>> getProductHighlights(
      BuildContext context,
      {int id}) async {
    List<ProductHighlightModel> lst = [];
    Response response = await get(Uri.parse(base + "/product/highlights/$id"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        data["image"] = base + data["image"];
        lst.add(ProductHighlightModel.fromJson(data));
      }
    }
    return lst;
  }

  static Future<ProductModel> getProduct(BuildContext context, {int id}) async {
    Response response = await get(Uri.parse(base + "/product/$id/"));
    var json = jsonDecode(response.body);
    return ProductModel.fromJson(json);
  }

  static Future<bool> createUser(
      {BuildContext context,
      String name,
      String email,
      File image,
      String password,
      String phone}) async {
    var stream = ByteStream(Stream.castFrom(image.openRead()));
    var length = await image.length();
    var uri = Uri.parse("$base/core/register/");
    var request = MultipartRequest("POST", uri);
    var multipartFile =
        MultipartFile('file', stream, length, filename: basename(image.path));
    request.files.add(multipartFile);
    request.fields.addAll(
        {"name": name, "email": email, "password": password, "phone": phone});
    var response = await request.send();
    var value = await response.stream.transform(utf8.decoder).first;
    var json = jsonDecode(value);
    if (response.statusCode == 200) {
      Provider.of<Data>(context, listen: false)
          .setUser(UserModel.fromJson(json));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(Strings.REGISTRATION_SUCCESSFUL)));
      return true;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(json["detail"])));
      return false;
    }
  }

  static Future<void> getCurrentUser(BuildContext context) async {
    Response response = await get(Uri.parse(base + "/core/user/"),
        headers: {"Authorization": await Auth.getAuthToken()});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      Provider.of<Data>(context, listen: false)
          .setUser(UserModel.fromJson(json));
    }
  }

  static Future<bool> loginUser(
      {BuildContext context, String email, String password}) async {
    Response response = await post(Uri.parse(base + "/core/login/"),
        body: {"email": email, "password": password});
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Provider.of<Data>(context, listen: false)
          .setUser(UserModel.fromJson(json));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(Strings.LOGIN_SUCCESSFUL)));
      return true;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(json["detail"])));
      return false;
    }
  }

  static Future<void> updateUser(
      {BuildContext context, String name, File image, String phone}) async {
    var uri = Uri.parse("$base/core/update/");
    var value;
    var response;
    if (image != null) {
      var stream = ByteStream(Stream.castFrom(image.openRead()));
      var length = await image.length();
      var request = MultipartRequest("PUT", uri);
      request.headers.addAll({"Authorization": await Auth.getAuthToken()});
      var multipartFile =
          MultipartFile('file', stream, length, filename: basename(image.path));
      request.files.add(multipartFile);
      request.fields.addAll({"name": name, "phone": phone});
      response = await request.send();
      value = await response.stream.transform(utf8.decoder).first;
    } else {
      response = await put(uri,
          body: {"name": name, "phone": phone},
          headers: {"Authorization": await Auth.getAuthToken()});
      value = response.body;
    }
    var json = jsonDecode(value);
    if (response.statusCode == 200) {
      Provider.of<Data>(context, listen: false)
          .setUser(UserModel.fromJson(json));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(Strings.UPDATE_SUCCESSFUL)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(json["detail"])));
    }
  }

  static Future<List<AddressModel>> getUserAddresses(
      BuildContext context) async {
    List<AddressModel> lst = [];
    Response response = await get(Uri.parse(base + "/core/address/"),
        headers: {"Authorization": await Auth.getAuthToken()});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        lst.add(AddressModel.fromJson(data));
      }
    }
    return lst;
  }

  static Future<void> addUserAddresses(BuildContext context, String name,
      String address, String pin, String phone) async {
    await post(Uri.parse(base + "/core/address/"),
        headers: {"Authorization": await Auth.getAuthToken()},
        body: {"name": name, "address": address, "pin": pin, "phone": phone});
  }

  static Future<void> updateUserAddresses(BuildContext context, int id,
      String name, String address, String pin, String phone) async {
    await put(Uri.parse(base + "/core/address/"), headers: {
      "Authorization": await Auth.getAuthToken()
    }, body: {
      "id": id.toString(),
      "name": name,
      "address": address,
      "pin": pin,
      "phone": phone
    });
  }

  static Future<void> deleteUserAddresses(int id) async {
    await delete(Uri.parse(base + "/core/address/"), headers: {
      "Authorization": await Auth.getAuthToken()
    }, body: {
      "id": id.toString(),
    });
  }

  static Future<void> getCartItems(BuildContext context) async {
    List<CartModel> lst = [];
    Response response = await get(Uri.parse(base + "/cart/"),
        headers: {"Authorization": await Auth.getAuthToken()});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        lst.add(CartModel.fromJson(data));
      }
    }
    Provider.of<Data>(context, listen: false).replaceCartItems(lst);
  }

  static Future<void> addCartItems(
      BuildContext context, int product, int count) async {
    for (CartModel model
        in Provider.of<Data>(context, listen: false).cartItems) {
      if (model.productId == product) {
        await updateCartItems(context, model.id, count, true);
        return;
      }
    }
    await post(Uri.parse(base + "/cart/"), headers: {
      "Authorization": await Auth.getAuthToken()
    }, body: {
      "product": product.toString(),
      "count": count.toString(),
    });
    await getCartItems(context);
  }

  static Future<void> updateCartItems(
      BuildContext context, int id, int count, bool fromFunction) async {
    await put(Uri.parse(base + "/cart/"), headers: {
      "Authorization": await Auth.getAuthToken()
    }, body: {
      "id": id.toString(),
      "count": count.toString(),
      "fromFunction": fromFunction.toString()
    });
    await getCartItems(context);
  }

  static Future<void> deleteCartItems(BuildContext context, int id) async {
    await delete(Uri.parse(base + "/cart/"), headers: {
      "Authorization": await Auth.getAuthToken()
    }, body: {
      "id": id.toString(),
    });
    await getCartItems(context);
  }

  static Future<List<OrderModel>> getOrders(BuildContext context) async {
    List<OrderModel> lst = [];
    Response response = await get(Uri.parse(base + "/orders/"),
        headers: {"Authorization": await Auth.getAuthToken()});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        lst.add(OrderModel.fromJson(data));
      }
    }
    return lst;
  }

  static Future<OrderModel> getOrder(BuildContext context, int id) async {
    List<OrderModel> lst = [];
    Response response = await get(Uri.parse(base + "/orders/$id"),
        headers: {"Authorization": await Auth.getAuthToken()});
    var json = jsonDecode(response.body);
    return OrderModel.fromJson(json);
  }

  static Future<void> addOrder(
      BuildContext context, String payment, String address) async {
    for (CartModel model
        in Provider.of<Data>(context, listen: false).cartItems) {
      post(Uri.parse(base + "/orders/"), headers: {
        "Authorization": await Auth.getAuthToken()
      }, body: {
        "product": model.productId.toString(),
        "total_price": (model.price * model.count + 70).toString(),
        "payment_method": payment,
        "address": address,
        "quantity": model.count.toString(),
      });
    }
    await getCartItems(context);
  }

  static Future<void> cancelOrder(BuildContext context, int id) async {
    await put(Uri.parse(base + "/orders/"), headers: {
      "Authorization": await Auth.getAuthToken()
    }, body: {
      "id": id.toString(),
    });
  }

  static Future<List<ProductReviewModel>> getProductReviews(
      BuildContext context,
      {int id}) async {
    List<ProductReviewModel> lst = [];
    Response response = await get(Uri.parse(base + "/product/reviews/$id"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var data in json) {
        lst.add(ProductReviewModel.fromJson(data));
      }
    }
    return lst;
  }

  static Future<ProductReviewModel> getProductReview(BuildContext context,
      {int id}) async {
    Response response = await get(Uri.parse(base + "/product/review/$id/"),
        headers: {"Authorization": await Auth.getAuthToken()});
    var json = jsonDecode(response.body);
    var product = ProductReviewModel.fromJson(json);
    return product;
  }

  static Future<void> addProductReview(BuildContext context,
      {int id, String description, double rating}) async {
    await post(Uri.parse(base + "/product/review/$id/"),
        headers: {"Authorization": await Auth.getAuthToken()},
        body: {"description": description, "rating": rating.toString()});
  }

  static Future<void> updateProductReview(BuildContext context,
      {int id, ProductReviewModel model}) async {
    await put(Uri.parse(base + "/product/review/$id/"), headers: {
      "Authorization": await Auth.getAuthToken()
    }, body: {
      "description": model.description,
      "rating": model.rating.toString(),
      "id": model.id.toString()
    });
  }

  static Future<int> checkWishlist(BuildContext context,
      {int productId}) async {
    Response response = await get(
        Uri.parse(base + "/product/wishlist/$productId/"),
        headers: {"Authorization": await Auth.getAuthToken()});
    return int.parse(response.body);
  }

  static Future<void> addToWishlist(BuildContext context,
      {int productId}) async {
    await post(Uri.parse(base + "/product/wishlist/$productId/"),
        headers: {"Authorization": await Auth.getAuthToken()});
  }

  static Future<void> removeWishlist(BuildContext context,
      {int wishlistId}) async {
    await delete(Uri.parse(base + "/product/wishlist/$wishlistId/"),
        headers: {"Authorization": await Auth.getAuthToken()});
  }
}
