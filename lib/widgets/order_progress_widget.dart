import 'package:e_commerce/helper/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class OrderProgress extends StatelessWidget {
  final String progress;

  OrderProgress({this.progress});

  @override
  Widget build(BuildContext context) {
    Color ordered;
    Color processingOrder;
    Color outForDelivery;
    Color delivered;

    if (progress == Strings.ORDERED) {
      ordered = Colors.green;
      processingOrder = Colors.grey;
      outForDelivery = Colors.grey;
      delivered = Colors.grey;
    } else if (progress == Strings.PROCESSING_ORDER) {
      ordered = Colors.green;
      processingOrder = Colors.green;
      outForDelivery = Colors.grey;
      delivered = Colors.grey;
    } else if (progress == Strings.OUT_FOR_DELIVERY) {
      ordered = Colors.green;
      processingOrder = Colors.green;
      outForDelivery = Colors.green;
      delivered = Colors.grey;
    } else if (progress == Strings.DELIVERED) {
      ordered = Colors.green;
      processingOrder = Colors.green;
      outForDelivery = Colors.green;
      delivered = Colors.green;
    } else if (progress == Strings.CANCELED) {
      ordered = Colors.red;
    }

    return Container(
      child: progress != Strings.CANCELED
          ? Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: 2.sp,
                          height: 50.sp,
                          color: ordered,
                        ),
                        CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: ordered,
                          child: CircleAvatar(
                            radius: 12.sp,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 8.sp,
                              backgroundColor: ordered,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.sp),
                      child: Text(
                        Strings.ORDERED,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 2.sp,
                          height: 80.sp,
                          color: processingOrder,
                        ),
                        CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: processingOrder,
                          child: CircleAvatar(
                            radius: 12.sp,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 8.sp,
                              backgroundColor: processingOrder,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Text(
                      Strings.PROCESSING_ORDER,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 2.sp,
                          height: 80.sp,
                          color: outForDelivery,
                        ),
                        CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: outForDelivery,
                          child: CircleAvatar(
                            radius: 12.sp,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 8.sp,
                              backgroundColor: outForDelivery,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Text(
                      Strings.OUT_FOR_DELIVERY,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: 2.sp,
                          height: 40.sp,
                          color: delivered,
                        ),
                        CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: delivered,
                          child: CircleAvatar(
                            radius: 12.sp,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 8.sp,
                              backgroundColor: delivered,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.sp),
                      child: Text(
                        Strings.DELIVERED,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: 2.sp,
                          height: 50.sp,
                          color: ordered,
                        ),
                        CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: ordered,
                          child: CircleAvatar(
                            radius: 12.sp,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 8.sp,
                              backgroundColor: ordered,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.sp),
                      child: Text(
                        Strings.ORDERED,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: 2.sp,
                          height: 40.sp,
                          color: Colors.red,
                        ),
                        CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: Colors.red,
                          child: CircleAvatar(
                            radius: 12.sp,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 8.sp,
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.sp),
                      child: Text(
                        Strings.CANCELED,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
