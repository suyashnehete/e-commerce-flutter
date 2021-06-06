import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/widgets/category_widget.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Container(
        margin: EdgeInsets.only(top: 5.sp),
        child: FutureBuilder<List<CategoryModel>>(
          future: API.getAllCategories(context),
          builder: (context, list) {
            if (list.hasData) {
              return GridView.builder(
                padding: EdgeInsets.all(10.sp),
                itemCount: list.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.sp,
                  mainAxisSpacing: 10.sp,
                  mainAxisExtent: 135.sp,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: CategoryWidget(
                      model: list.data[index],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
