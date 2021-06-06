import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/Strings.dart';
import 'package:e_commerce/screens/home/home.dart';
import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:e_commerce/screens/login/signup_screen.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class LoginSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.sp,
            horizontal: 20.sp,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Hero(
                  tag: "logo",
                  child: appNameHeading,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50.sp,
                    height: 0.5.sp,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Text(
                    Strings.LOGIN_SIGNUP_TAG,
                    style: GoogleFonts.dancingScript(
                      textStyle: TextStyle(
                        foreground: Paint()..shader = linearGradient,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomOutlineButton(
                    text: Strings.SIGNUP,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.sp,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 0.5.sp,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                          child: Text(
                            Strings.OR_SKIP,
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 0.5.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomOutlineButton(
                    text: Strings.LOGIN,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
