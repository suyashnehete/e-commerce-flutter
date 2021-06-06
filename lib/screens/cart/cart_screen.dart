import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/screens/payment/payment_screen.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Consumer<Data>(
                builder: (context, data, child) {
                  if (data.cartItems.length == 0) {
                    return Center(
                      child: Text(
                        Strings.YOUR_CART_IS_EMPTY,
                        style: homeTextStyle,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(20.sp),
                      itemCount: data.cartItems.length + 1,
                      itemBuilder: (context, index) {
                        if (index == data.cartItems.length) {
                          int price = 0;
                          for (CartModel model in data.cartItems) {
                            price += (model.price * model.count);
                          }
                          return CartPriceTile(
                            delivery: data.cartItems.length * 70,
                            total: price,
                          );
                        }
                        return CartTile(
                          name: data.cartItems[index].name,
                          price: data.cartItems[index].price,
                          image: data.cartItems[index].image,
                          quantity: data.cartItems[index].count,
                          id: data.cartItems[index].id,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Provider.of<Data>(context).cartItems.length == 0
                ? SizedBox()
                : TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(10.sp),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(buttonColor),
                    ),
                    child: Text(
                      Strings.CHECKOUT,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class CartTile extends StatelessWidget {
  final int quantity;
  final int price;
  final String name;
  final String image;
  final int id;

  CartTile({this.quantity, this.price, this.name, this.image, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 150.sp,
      child: Dismissible(
        key: ValueKey<int>(id),
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 30.sp,
              ),
              Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 30.sp,
              )
            ],
          ),
        ),
        onDismissed: (direction) async {
          await API.deleteCartItems(context, id);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(Strings.ITEM_REMOVED)));
        },
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.sp),
                  child: Image.network(
                    image,
                    height: 90.sp,
                    width: 35.w,
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
                          name,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.RS + (price * quantity).toString(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 2.sp,
                            ),
                            Text(
                              Strings.DELIVERY_CHARGE,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.sp),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (quantity != 1) {
                                API.updateCartItems(
                                    context, id, quantity - 1, false);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 3.sp),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(),
                                ),
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            quantity.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              API.updateCartItems(
                                  context, id, quantity + 1, false);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 3.sp),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(),
                                ),
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      await API.deleteCartItems(context, id);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(Strings.ITEM_REMOVED)));
                    },
                    child: Text(
                      Strings.DELETE,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        vertical: 3.sp,
                      )),
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: Color(0xFF000000),
                        ),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CartPriceTile extends StatelessWidget {
  final int total;
  final int delivery;

  CartPriceTile({this.total, this.delivery});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.WPRICE,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
              Text(
                Strings.RS + total.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.WDELIVERY_CHARGE,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
              Text(
                Strings.RS + delivery.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          Container(
            color: Colors.grey.shade700,
            width: 100.w,
            height: 1.sp,
            margin: EdgeInsets.symmetric(vertical: 5.sp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.TOTAL,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
              Text(
                Strings.RS + (total + delivery).toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
