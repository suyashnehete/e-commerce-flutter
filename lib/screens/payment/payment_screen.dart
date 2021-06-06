import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/address_model.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/screens/address/address_screen.dart';
import 'package:e_commerce/widgets/address_tile.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

enum PaymentMethods { WALLET, CREDIT_CARD, UPI, NET_BANKING, COD, EMI }

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethods paymentMethods = PaymentMethods.CREDIT_CARD;

  int getTotalCost() {
    int price = 0;
    for (CartModel model
        in Provider.of<Data>(context, listen: false).cartItems) {
      price += (model.price * model.count);
    }
    price += (Provider.of<Data>(context, listen: false).cartItems.length * 70);
    return price;
  }

  String address = "";

  Future placeOrder() async {
    var payment = Strings.CREDIT_CARD;
    switch (paymentMethods) {
      case PaymentMethods.CREDIT_CARD:
        payment = Strings.CREDIT_CARD;
        break;
      case PaymentMethods.UPI:
        payment = Strings.UPI;
        break;
      case PaymentMethods.WALLET:
        payment = Strings.WALLET;
        break;
      case PaymentMethods.NET_BANKING:
        payment = Strings.NET_BANKING;
        break;
      case PaymentMethods.EMI:
        payment = Strings.EMI;
        break;
      case PaymentMethods.COD:
        payment = Strings.COD;
        break;
    }
    await API.addOrder(context, payment, address);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20.sp),
                      padding: EdgeInsets.all(10.sp),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.ADDRESS_HINT,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.black,
                            ),
                          ),
                          FutureBuilder<List<AddressModel>>(
                            future: API.getUserAddresses(context),
                            builder: (context, list) {
                              if (list.hasData) {
                                if (list.data.length == 0) {
                                  return Center(
                                    child: ElevatedButton(
                                      child: Text(Strings.ADD_ADDRESS),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddressScreen(),
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                buttonColor),
                                      ),
                                    ),
                                  );
                                }
                                address =
                                    "${list.data[0].name}\n${list.data[0].phone}\n${list.data[0].address}\n${list.data[0].pin}";
                                return CupertinoPicker.builder(
                                  childCount: list.data.length,
                                  itemExtent: 75.sp,
                                  useMagnifier: true,
                                  onSelectedItemChanged: (index) {
                                    address =
                                        "${list.data[index].name}\n${list.data[index].phone}\n${list.data[index].address}\n${list.data[index].pin}";
                                  },
                                  itemBuilder: (context, index) {
                                    AddressModel model = list.data[index];
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5.sp,
                                        horizontal: 15.sp,
                                      ),
                                      width: 100.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.name,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                          Text(
                                            model.phone,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                          Text(
                                            model.address,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                          Text(
                                            model.pin,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20.sp),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: Text(
                              Strings.PAYMENT,
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                title: Text(Strings.CREDIT_CARD),
                                leading: Radio(
                                  activeColor: buttonColor,
                                  value: PaymentMethods.CREDIT_CARD,
                                  groupValue: paymentMethods,
                                  onChanged: (val) {
                                    setState(() {
                                      paymentMethods = val;
                                    });
                                  },
                                ),
                                trailing:
                                    FaIcon(FontAwesomeIcons.solidCreditCard),
                              ),
                              Container(
                                color: Colors.grey.shade700,
                                height: 0.5.sp,
                                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                              ),
                              ListTile(
                                title: Text(Strings.UPI),
                                leading: Radio(
                                  activeColor: buttonColor,
                                  value: PaymentMethods.UPI,
                                  groupValue: paymentMethods,
                                  onChanged: (val) {
                                    setState(() {
                                      paymentMethods = val;
                                    });
                                  },
                                ),
                                trailing: FaIcon(FontAwesomeIcons.at),
                              ),
                              Container(
                                color: Colors.grey.shade700,
                                height: 0.5.sp,
                                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                              ),
                              ListTile(
                                title: Text(Strings.WALLET),
                                leading: Radio(
                                  activeColor: buttonColor,
                                  value: PaymentMethods.WALLET,
                                  groupValue: paymentMethods,
                                  onChanged: (val) {
                                    setState(() {
                                      paymentMethods = val;
                                    });
                                  },
                                ),
                                trailing: FaIcon(FontAwesomeIcons.wallet),
                              ),
                              Container(
                                color: Colors.grey.shade700,
                                height: 0.5.sp,
                                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                              ),
                              ListTile(
                                title: Text(Strings.NET_BANKING),
                                leading: Radio(
                                  activeColor: buttonColor,
                                  value: PaymentMethods.NET_BANKING,
                                  groupValue: paymentMethods,
                                  onChanged: (val) {
                                    setState(() {
                                      paymentMethods = val;
                                    });
                                  },
                                ),
                                trailing: FaIcon(FontAwesomeIcons.battleNet),
                              ),
                              Container(
                                color: Colors.grey.shade700,
                                height: 0.5.sp,
                                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                              ),
                              ListTile(
                                title: Text(Strings.EMI),
                                leading: Radio(
                                  activeColor: buttonColor,
                                  value: PaymentMethods.EMI,
                                  groupValue: paymentMethods,
                                  onChanged: (val) {
                                    setState(() {
                                      paymentMethods = val;
                                    });
                                  },
                                ),
                                trailing: FaIcon(FontAwesomeIcons.coins),
                              ),
                              Container(
                                color: Colors.grey.shade700,
                                height: 0.5.sp,
                                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                              ),
                              ListTile(
                                title: Text(Strings.COD),
                                leading: Radio(
                                  activeColor: buttonColor,
                                  value: PaymentMethods.COD,
                                  groupValue: paymentMethods,
                                  onChanged: (val) {
                                    setState(() {
                                      paymentMethods = val;
                                    });
                                  },
                                ),
                                trailing: FaIcon(FontAwesomeIcons.home),
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade800,
                    offset: Offset(0.0, 1),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: EdgeInsets.all(5.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.RS + getTotalCost().toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await placeOrder();
                      await Alert(
                        context: context,
                        title: Strings.ORDER_PLACED,
                        desc: Strings.ORDER_PLACED_SUCCESSFULLY,
                        type: AlertType.success,
                      ).show();
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(buttonColor),
                    ),
                    child: Text(
                      Strings.PROCEED,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
