import 'dart:async';

import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/Strings.dart';
import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/helper/shared_preferences.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/screens/home/home.dart';
import 'package:e_commerce/screens/login/login_signup_screen.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void loadData() async {
    await API.getOffers(context);
    await API.getTopCategories(context);
    await API.getTopProducts(context);
    await API.getTrendingProducts(context);
    Provider.of<Data>(context, listen: false).setIsAuthenticated();
    if (await Auth.getAuthToken() != null) {
      await API.getCurrentUser(context);
      await API.getCartItems(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      return;
    }
    if (await Auth.isUserFirstTime()) {
      Auth.setUserFirstTime(false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginSignupScreen(),
        ),
      );
    } else {
      Auth.setUserFirstTime(false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: Center(
        child: Hero(
          tag: "logo",
          child: Text(
            Strings.APP_NAME,
            style: GoogleFonts.dancingScript(
              textStyle: TextStyle(
                foreground: Paint()..shader = linearGradient,
                fontSize: 50.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
