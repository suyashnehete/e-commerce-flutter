import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/models/product_review_model.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:e_commerce/widgets/order_progress_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class OrderScreen extends StatefulWidget {
  static final headingStyle = TextStyle(
    fontSize: 14.sp,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static final textStyle = TextStyle(
    fontSize: 12.sp,
    color: Colors.black,
  );
  static Widget divider = Container(
    height: 1.sp,
    color: Colors.grey.shade500,
  );

  final int id;

  OrderScreen({this.id});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: SingleChildScrollView(
        child: FutureBuilder<OrderModel>(
          future: API.getOrder(context, widget.id),
          builder: (context, model) {
            if (model.hasData) {
              return FutureBuilder<ProductReviewModel>(
                future: API.getProductReview(context, id: model.data.product),
                builder: (context, review) {
                  if (review.hasData) {
                    return Container(
                      margin: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.sp),
                        ),
                        border: Border.all(),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.sp,
                              left: 10.sp,
                              right: 10.sp,
                              bottom: 10.sp,
                            ),
                            child: Row(
                              children: [
                                Image.network(
                                  model.data.image,
                                  width: 20.w,
                                  height: 60.sp,
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Expanded(
                                  child: Text(
                                    model.data.name,
                                    style: OrderScreen.headingStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          OrderScreen.divider,
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.sp,
                              left: 10.sp,
                              right: 10.sp,
                              bottom: 10.sp,
                            ),
                            child: Text(
                              Strings.ORDER_STATUS,
                              style: OrderScreen.headingStyle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 10.sp,
                              left: 10.sp,
                              right: 10.sp,
                            ),
                            child: OrderProgress(
                              progress: model.data.status,
                            ),
                          ),
                          OrderScreen.divider,
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.sp,
                              left: 10.sp,
                              right: 10.sp,
                              bottom: 10.sp,
                            ),
                            child: Text(
                              Strings.ORDER_DETAILS,
                              style: OrderScreen.headingStyle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10.sp,
                              right: 10.sp,
                              bottom: 10.sp,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        Strings.ORDER_DATE,
                                        style: OrderScreen.textStyle,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        model.data.orderedDate,
                                        style: OrderScreen.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                model.data.status == Strings.CANCELED
                                    ? SizedBox()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              Strings.DELIVERY_DATE,
                                              style: OrderScreen.textStyle,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              model.data.deliveryDate +
                                                  (model.data.status ==
                                                          Strings.DELIVERED
                                                      ? ""
                                                      : Strings.EXPECTED),
                                              style: OrderScreen.textStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        Strings.WPRICE,
                                        style: OrderScreen.textStyle,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        Strings.RS +
                                            model.data.price.toString(),
                                        style: OrderScreen.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        Strings.QUANTITY,
                                        style: OrderScreen.textStyle,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        model.data.quantity.toString(),
                                        style: OrderScreen.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        Strings.WPAYMENT,
                                        style: OrderScreen.textStyle,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        model.data.payment,
                                        style: OrderScreen.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        Strings.ADDRESS_HINT,
                                        style: OrderScreen.textStyle,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        model.data.address,
                                        softWrap: true,
                                        style: OrderScreen.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          model.data.status == Strings.CANCELED
                              ? SizedBox()
                              : TextButton(
                                  onPressed: () async {
                                    if (model.data.status ==
                                        Strings.DELIVERED) {
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ReviewDialog(
                                            model: review.data,
                                            id: model.data.product,
                                          );
                                        },
                                      );
                                    } else {
                                      await API.cancelOrder(
                                          context, model.data.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  Strings.ORDER_CANCELED)));
                                    }
                                    setState(() {});
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      model.data.status == Strings.DELIVERED
                                          ? buttonColor
                                          : Colors.red,
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15.sp),
                                          bottomLeft: Radius.circular(15.sp),
                                        ),
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all(
                                      EdgeInsets.all(10.sp),
                                    ),
                                  ),
                                  child: Text(
                                    model.data.status == Strings.DELIVERED
                                        ? (review.data.id == 0
                                            ? Strings.GIVE_REVIEW
                                            : Strings.EDIT_REVIEW)
                                        : Strings.CANCEL_ORDER,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
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

class ReviewDialog extends StatelessWidget {
  final ProductReviewModel model;
  final int id;
  ReviewDialog({this.model, this.id});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: model.description);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.sp),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.id == 0 ? Strings.GIVE_REVIEW : Strings.EDIT_REVIEW,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 7.sp,
                ),
                RatingBar.builder(
                  initialRating: model.rating,
                  minRating: 1,
                  tapOnlyMode: true,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20.sp,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    model.rating = rating;
                  },
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: TextField(
                    minLines: 3,
                    maxLines: 10,
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                    style: textFieldStyle,
                    decoration: textFieldDecoration(
                      hint: Strings.REVIEW,
                      icon: Icons.rate_review,
                    ),
                    onChanged: (val) {
                      model.description = val;
                    },
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (model.id == 0) {
                await API.addProductReview(context,
                    id: id,
                    rating: model.rating,
                    description: model.description);
              } else {
                await API.updateProductReview(context, id: id, model: model);
              }
              Navigator.pop(context);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15.sp),
                    bottomLeft: Radius.circular(15.sp),
                  ),
                ),
              ),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 10.sp),
              ),
              backgroundColor: MaterialStateProperty.all(buttonColor),
            ),
            child: Text(
              Strings.SUBMIT,
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
