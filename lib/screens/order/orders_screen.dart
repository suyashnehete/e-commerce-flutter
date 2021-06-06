import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/screens/order/order_screen.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    API.getOrders(context);
    return CustomScaffold(
      child: FutureBuilder<List<OrderModel>>(
        future: API.getOrders(context),
        builder: (context, list) {
          if (list.hasData) {
            if (list.data.length == 0) {
              return Center(
                child: Text(
                  Strings.NO_ORDERS,
                  style: homeTextStyle,
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(20.sp),
                itemCount: list.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(
                              id: list.data[index].id,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                list.data[index].image,
                                width: 35.w,
                                height: 80.sp,
                              ),
                              SizedBox(
                                width: 5.sp,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      list.data[index].name,
                                      maxLines: 4,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      Strings.ORDER_DATE +
                                          list.data[index].orderedDate,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          index != list.data.length - 1
                              ? Container(
                                  color: Colors.grey.shade500,
                                  height: 0.5.sp,
                                  margin: EdgeInsets.symmetric(vertical: 10.sp),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
