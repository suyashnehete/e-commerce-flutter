import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/product/product_screen.dart';
import 'package:e_commerce/widgets/wishlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class ProductWidget extends StatelessWidget {
  final double width;
  final ProductModel model;

  ProductWidget({this.width, this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(
                id: model.id,
              ),
            ),
          );
        },
        child: Card(
          elevation: 5.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.sp),
                child: Image.network(
                  model.image,
                  height: 30.w,
                  width: width,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.sp,
                  vertical: 3.sp,
                ),
                child: Text(
                  model.name,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.sp,
                        ),
                        child: Text(
                          Strings.RS + model.price.toString(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.sp, bottom: 5.sp),
                        child: model.rating == 0
                            ? Text(Strings.NO_REVIEWS)
                            : RatingBar.builder(
                                initialRating: model.rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 13.sp,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Wishlist(
                      id: model.id,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final ProductModel model;

  ProductTile({this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 120.sp,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(
                id: model.id,
              ),
            ),
          );
        },
        child: Card(
          elevation: 5.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.sp),
                child: Image.network(
                  model.image,
                  height: 100.h,
                  width: 40.w,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.sp,
                        right: 8.sp,
                        top: 10.sp,
                        bottom: 3.sp,
                      ),
                      child: Text(
                        model.name,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.sp,
                              ),
                              child: Text(
                                Strings.RS + model.price.toString(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 8.sp, bottom: 5.sp),
                              child: model.rating == 0
                                  ? Text(Strings.NO_REVIEWS)
                                  : RatingBar.builder(
                                      initialRating: model.rating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 13.sp,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Wishlist(
                            id: model.id,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
