import 'dart:async';
import 'dart:io';

import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/Strings.dart';
import 'package:e_commerce/screens/home/home.dart';
import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:e_commerce/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _image;
  final picker = ImagePicker();
  String name = "";
  String email = "";
  String phone = "";
  String password = "";

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _image = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
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
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30.sp),
                    child: Hero(
                      tag: "logo",
                      child: appNameHeading,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: getImage,
                      child: CircleAvatar(
                        radius: 40.sp,
                        child: _image == null
                            ? Icon(
                                Icons.person,
                                size: 80.sp,
                                color: Colors.grey,
                              )
                            : null,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            _image != null ? FileImage(_image) : null,
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    TextField(
                      decoration: textFieldDecoration(
                        hint: Strings.NAME_HINT,
                        icon: Icons.person,
                      ),
                      style: textFieldStyle,
                      keyboardType: TextInputType.name,
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    TextField(
                      decoration: textFieldDecoration(
                        hint: Strings.EMAIL_HINT,
                        icon: Icons.email_rounded,
                      ),
                      style: textFieldStyle,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    TextField(
                      decoration: textFieldDecoration(
                        hint: Strings.PHONE_HINT,
                        icon: Icons.phone,
                      ),
                      style: textFieldStyle,
                      keyboardType: TextInputType.phone,
                      onChanged: (val) {
                        phone = val;
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
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        Strings.HAVE_ACCOUNT,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.sp),
                  child: CustomGradientButton(
                    onPressed: () async {
                      bool isRegistered = await API.createUser(
                          context: context,
                          name: name,
                          image: _image,
                          email: email,
                          password: password,
                          phone: phone);
                      if (isRegistered) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    text: Strings.SIGNUP,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
