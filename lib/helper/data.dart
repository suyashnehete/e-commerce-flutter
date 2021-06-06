import 'package:e_commerce/helper/shared_preferences.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/product_review_model.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  bool isAuthenticated = false;

  void setIsAuthenticated() async {
    isAuthenticated = await Auth.getAuthToken() != null;
    notifyListeners();
  }

  UserModel user;
  void setUser(UserModel userModel) {
    this.user = userModel;
    isAuthenticated = true;
    Auth.setAuthToken(user.token);
    notifyListeners();
  }

  List<String> offers = [];
  void addOffer(String url) {
    offers.add(url);
    notifyListeners();
  }

  List<CategoryModel> topCategories = [];
  void addTopCategory(CategoryModel model) {
    topCategories.add(model);
    notifyListeners();
  }

  List<ProductModel> topProducts = [];
  void addTopProduct(ProductModel model) {
    topProducts.add(model);
    notifyListeners();
  }

  List<ProductModel> trendingProducts = [];
  void addTrendingProduct(ProductModel model) {
    trendingProducts.add(model);
    notifyListeners();
  }

  List<CartModel> cartItems = [];
  void replaceCartItems(List<CartModel> model) {
    cartItems = model;
    notifyListeners();
  }
}
