import 'package:e_commerce/helper/strings.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsOffers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        children: [
          ListTile(
            leading: Icon(
              Icons.local_offer,
              color: Colors.green,
            ),
            title: Text(
              Strings.OFFERS,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 100.w,
            height: 85.sp,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    OfferTile(
                      title: Strings.OFFER_ONE_TITLE,
                      detail: Strings.OFFER_ONE_DETAIL,
                    ),
                    OfferTile(
                      title: Strings.OFFER_TWO_TITLE,
                      detail: Strings.OFFER_TWO_DETAIL,
                    ),
                    OfferTile(
                      title: Strings.OFFER_THREE_TITLE,
                      detail: Strings.OFFER_THREE_DETAIL,
                    ),
                    OfferTile(
                      title: Strings.OFFER_FOUR_TITLE,
                      detail: Strings.OFFER_FOUR_DETAIL,
                    ),
                    OfferTile(
                      title: Strings.OFFER_FIVE_TITLE,
                      detail: Strings.OFFER_FIVE_DETAIL,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
        ],
      ),
    );
  }
}

class OfferTile extends StatelessWidget {
  final String title;
  final String detail;

  OfferTile({this.title, this.detail});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.sp),
        ),
      ),
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.sp,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.sp),
          ),
        ),
        width: 120.sp,
        height: 85.sp,
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 3.sp),
            child: Text(
              detail,
              style: TextStyle(
                color: Colors.black,
                fontSize: 11.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
