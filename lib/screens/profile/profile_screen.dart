import 'dart:io';

import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _image;

  final picker = ImagePicker();

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

  TextEditingController email;
  TextEditingController phone;
  TextEditingController name;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    email = TextEditingController(text: Provider.of<Data>(context).user.email);
    phone = TextEditingController(text: Provider.of<Data>(context).user.phone);
    name = TextEditingController(text: Provider.of<Data>(context).user.name);
    return CustomScaffold(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: 40.sp,
                  backgroundColor: Colors.white,
                  backgroundImage: _image != null
                      ? FileImage(_image)
                      : NetworkImage(Provider.of<Data>(context).user.image),
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
                controller: name,
                style: textFieldStyle,
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10.sp,
              ),
              TextField(
                enableInteractiveSelection: false,
                decoration: textFieldDecoration(
                  hint: Strings.EMAIL_HINT,
                  icon: Icons.email_rounded,
                ),
                readOnly: true,
                controller: email,
                style: textFieldStyle,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10.sp,
              ),
              TextField(
                decoration: textFieldDecoration(
                  hint: Strings.PHONE_HINT,
                  icon: Icons.phone,
                ),
                controller: phone,
                style: textFieldStyle,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 10.sp,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonColor),
                ),
                onPressed: () {
                  API.updateUser(
                      context: context,
                      phone: phone.text,
                      image: _image,
                      name: name.text);
                },
                child: Text(
                  Strings.UPDATE,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
