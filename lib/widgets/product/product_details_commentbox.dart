import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/product_review_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class ProductDetailCommentBox extends StatelessWidget {
  final List<ProductReviewModel> comments;

  ProductDetailCommentBox({this.comments});

  @override
  Widget build(BuildContext context) {
    List<Widget> lst = [];

    for (var i in comments) {
      lst.add(
        CommentList(
          description: i.description,
          rating: i.rating,
          name: i.user,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade800,
            offset: Offset(0.0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            Strings.REVIEWS,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Column(
            children: lst,
          ),
        ],
      ),
    );
  }
}

class CommentList extends StatelessWidget {
  final String name;
  final double rating;
  final String description;

  CommentList({this.name, this.rating, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.sp),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.sp),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.sp),
                ),
              ),
              elevation: 5.sp,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 15.sp,
                  left: 10.sp,
                  right: 10.sp,
                  bottom: 10.sp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.sp),
            child: Align(
              alignment: Alignment.topLeft,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.sp),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.sp),
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        rating.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 11.sp),
                      ),
                      SizedBox(
                        width: 3.sp,
                      ),
                      FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.white,
                        size: 8.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
