import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/screens/category/categories_screen.dart';
import 'package:e_commerce/screens/product/products_screen.dart';
import 'package:e_commerce/widgets/category_widget.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:e_commerce/widgets/product/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 100.w,
                height: 200.sp,
                child: Consumer<Data>(
                  builder: (context, data, child) {
                    return Swiper(
                      itemCount: data.offers.length,
                      viewportFraction: 1,
                      scale: 1,
                      duration: 500,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Image.network(
                            data.offers[index],
                            width: 100.w,
                            height: 200.sp,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: Text(
                        Strings.RECOMMENDED,
                        style: homeTextStyle,
                      ),
                    ),
                    Container(
                      width: 100.w,
                      height: 160.sp,
                      child: Consumer<Data>(
                        builder: (context, data, child) {
                          return Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return ProductWidget(
                                width: 50.w,
                                model: data.trendingProducts[index],
                              );
                            },
                            itemCount: data.trendingProducts.length,
                            viewportFraction: 0.5,
                            scale: 0.3,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  elevation: 5.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.sp,
                            vertical: 5.sp,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.TOP_CATEGORIES,
                                style: homeTextStyle,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoryScreen(),
                                    ),
                                  );
                                },
                                child: Text(Strings.SEE_ALL),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(buttonColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        Consumer<Data>(
                          builder: (context, data, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CategoryWidget(
                                  model: data.topCategories[0],
                                ),
                                CategoryWidget(
                                  model: data.topCategories[1],
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Consumer<Data>(
                          builder: (context, data, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CategoryWidget(
                                  model: data.topCategories[2],
                                ),
                                CategoryWidget(
                                  model: data.topCategories[3],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  elevation: 5.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.sp,
                            vertical: 5.sp,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.DEALS,
                                style: homeTextStyle,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductsScreen(
                                        query: "?search=",
                                      ),
                                    ),
                                  );
                                },
                                child: Text(Strings.SEE_ALL),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(buttonColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        Consumer<Data>(
                          builder: (context, data, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ProductWidget(
                                  width: 45.w,
                                  model: data.topProducts[0],
                                ),
                                ProductWidget(
                                  width: 45.w,
                                  model: data.topProducts[1],
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Consumer<Data>(
                          builder: (context, data, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ProductWidget(
                                  width: 45.w,
                                  model: data.topProducts[2],
                                ),
                                ProductWidget(
                                  width: 45.w,
                                  model: data.topProducts[3],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
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
