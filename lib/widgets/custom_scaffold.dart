import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/helper/shared_preferences.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/screens/address/address_screen.dart';
import 'package:e_commerce/screens/cart/cart_screen.dart';
import 'package:e_commerce/screens/home/home.dart';
import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:e_commerce/screens/login/login_signup_screen.dart';
import 'package:e_commerce/screens/order/orders_screen.dart';
import 'package:e_commerce/screens/product/products_screen.dart';
import 'package:e_commerce/screens/profile/profile_screen.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BackgroundScaffold extends StatelessWidget {
  final Widget child;

  BackgroundScaffold({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: child,
        ),
      ),
    );
  }
}

class CustomScaffold extends StatefulWidget {
  final Widget child;

  CustomScaffold({this.child});

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  bool isSearchOn = false;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = Strings.searchText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearchOn
            ? TextField(
                controller: _controller,
                decoration: textFieldDecoration(
                  hint: Strings.SEARCH,
                  icon: Icons.search,
                ).copyWith(
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      setState(() {
                        isSearchOn = false;
                      });
                    },
                  ),
                ),
                style: textFieldStyle,
                keyboardType: TextInputType.text,
                onSubmitted: (val) {
                  Strings.searchText = val;
                  setState(() {
                    setState(() {
                      isSearchOn = false;
                    });
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductsScreen(query: "?search=$val"),
                    ),
                  );
                },
              )
            : Text(Strings.APP_NAME),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        ),
        actions: [
          !isSearchOn
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearchOn = true;
                    });
                  },
                )
              : SizedBox(),
          !isSearchOn
              ? TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Auth.getAuthToken() == null
                            ? LoginScreen()
                            : CartScreen(),
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform(
                        child: FaIcon(
                          FontAwesomeIcons.shoppingCart,
                          color: Colors.white,
                        ),
                        transform: Matrix4.rotationY(3.14),
                        alignment: Alignment.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 3.5.sp,
                          right: 3.sp,
                        ),
                        child: Text(
                          Provider.of<Data>(context)
                              .cartItems
                              .length
                              .toString(),
                          style: TextStyle(
                            color: buttonColor,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
        ],
      ),
      drawer: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25.sp),
            bottomRight: Radius.circular(25.sp),
          ),
        ),
        width: 70.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.w,
              height: 160.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.sp),
                ),
                gradient: gradient,
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40.sp,
                        child: !Provider.of<Data>(context).isAuthenticated
                            ? Icon(
                                Icons.person,
                                size: 80.sp,
                                color: Colors.grey,
                              )
                            : null,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            Provider.of<Data>(context).isAuthenticated
                                ? NetworkImage(
                                    Provider.of<Data>(context).user.image)
                                : null,
                      ),
                      SizedBox(
                        height: 7.sp,
                      ),
                      Text(
                        "Welcome " +
                            (Provider.of<Data>(context, listen: false)
                                    .isAuthenticated
                                ? Provider.of<Data>(context)
                                    .user
                                    .name
                                    .split(" ")[0]
                                : Strings.GUEST),
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                      Provider.of<Data>(context, listen: false).isAuthenticated
                          ? Text(
                              Provider.of<Data>(context).user.email,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            CustomTextButton(
              text: Strings.HOME,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
            CustomTextButton(
              text: Strings.MY_ORDERS,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        !Provider.of<Data>(context, listen: false)
                                .isAuthenticated
                            ? LoginScreen()
                            : OrdersScreen(),
                  ),
                );
              },
            ),
            CustomTextButton(
              text: Strings.MY_ACCOUNT,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        !Provider.of<Data>(context, listen: false)
                                .isAuthenticated
                            ? LoginScreen()
                            : ProfileScreen(),
                  ),
                );
              },
            ),
            CustomTextButton(
              text: Strings.MY_ADDRESSES,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        !Provider.of<Data>(context, listen: false)
                                .isAuthenticated
                            ? LoginScreen()
                            : AddressScreen(),
                  ),
                );
              },
            ),
            CustomTextButton(
              text: Strings.WISHLIST,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        !Provider.of<Data>(context, listen: false)
                                .isAuthenticated
                            ? LoginScreen()
                            : ProductsScreen(
                          query: "wishlist/?search=",
                        ),
                  ),
                );
              },
            ),
            Provider.of<Data>(context, listen: false).isAuthenticated
                ? CustomTextButton(
                    text: Strings.LOGOUT,
                    onPressed: () {
                      Auth.removeAuthToken();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginSignupScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                  )
                : Container(),
          ],
        ),
      ),
      body: widget.child,
    );
  }
}
