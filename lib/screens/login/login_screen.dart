import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/screens/home/home.dart';
import 'package:e_commerce/screens/login/signup_screen.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:e_commerce/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";
    return BackgroundScaffold(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.sp,
            horizontal: 20.sp,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Hero(
                  tag: "logo",
                  child: appNameHeading,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: textFieldDecoration(
                      hint: Strings.EMAIL_HINT,
                      icon: Icons.account_circle_rounded,
                    ),
                    style: textFieldStyle,
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  PasswordField(
                    onChange: (val) {
                      password = val;
                    },
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                    child: Text(
                      Strings.NO_ACCOUNT,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
              CustomGradientButton(
                onPressed: () async {
                  bool isLogin = await API.loginUser(
                      context: context, password: password, email: email);
                  if (isLogin) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                text: Strings.LOGIN,
              )
            ],
          ),
        ),
      ),
    );
  }
}
