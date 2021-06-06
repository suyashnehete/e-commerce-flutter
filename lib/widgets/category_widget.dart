import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/screens/product/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel model;

  CategoryWidget({this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsScreen(
                query: "?search=${model.name}",
              ),
            ),
          );
        },
        child: Card(
          elevation: 5.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                model.image,
                height: 30.w,
                width: 40.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.sp,
                  vertical: 3.sp,
                ),
                child: Text(
                  Strings.STARTING_FROM + model.price.toString(),
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.sp,
                  right: 8.sp,
                  bottom: 5.sp,
                ),
                child: Text(
                  model.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
