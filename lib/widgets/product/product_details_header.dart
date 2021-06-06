import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../wishlist_widget.dart';

class ProductDetailsHeader extends StatefulWidget {
  final int price;
  final String name;
  final List<String> list;
  final double rating;
  final String seller;
  final int stock;
  final int id;

  ProductDetailsHeader(
      {this.price,
      this.name,
      this.list,
      this.rating,
      this.seller,
      this.stock,
      this.id});

  @override
  _ProductDetailsHeaderState createState() => _ProductDetailsHeaderState();
}

class _ProductDetailsHeaderState extends State<ProductDetailsHeader> {
  @override
  Widget build(BuildContext context) {
    SwiperController _controller = SwiperController();
    return Container(
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
          Container(
            width: 100.w,
            height: 150.sp,
            child: Swiper(
              itemCount: widget.list.length,
              duration: 1000,
              autoplay: true,
              controller: _controller,
              viewportFraction: 1,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Image.network(
                    widget.list[index],
                    width: 100.w,
                    height: 150.sp,
                  ),
                );
              },
            ),
          ),
          Container(
            width: 100.w,
            height: 33.sp,
            margin: EdgeInsets.only(top: 5.sp),
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _controller.move(index);
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        color: buttonColor,
                        padding: EdgeInsets.all(1.sp),
                        child: Image.network(
                          widget.list[index],
                          width: 30.sp,
                          height: 30.sp,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.sp,
              vertical: 3.sp,
            ),
            child: Text(
              widget.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.sp,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: widget.rating == 0
                  ? Text(Strings.NO_REVIEWS)
                  : Card(
                      elevation: 5,
                      child: Container(
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(
                            vertical: 3.sp, horizontal: 7.sp),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.rating.toStringAsFixed(1),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 11.sp),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.sp,
                      vertical: 3.sp,
                    ),
                    child: Text(
                      Strings.PRICE + widget.price.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.sp),
                    child: Text(
                      Strings.DELIVERY_CHARGE,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Wishlist(
                  id: widget.id,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.sp,
              right: 10.sp,
              bottom: 5.sp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.TOTAL + Strings.RS + (widget.price + 70).toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  widget.stock > 5
                      ? Strings.IN_STOCK
                      : (widget.stock < 1
                          ? Strings.OUT_OF_STOCK
                          : Strings.ONLY +
                              widget.stock.toString() +
                              Strings.LEFT_IN_STOCK),
                  style: TextStyle(
                    color: widget.stock > 5 ? Colors.green : Colors.red,
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.sp,
              right: 10.sp,
              bottom: 10.sp,
            ),
            child: Row(
              children: [
                Text(
                  Strings.SOLD_BY,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(
                  width: 2.sp,
                ),
                Text(
                  widget.seller,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(
                  width: 2.sp,
                ),
                Text(
                  Strings.AND,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(
                  width: 2.sp,
                ),
                Text(
                  Strings.APP_NAME,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(
                  width: 2.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
