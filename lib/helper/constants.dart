import 'package:e_commerce/helper/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

enum SortMenuItems { FEATURED, PRICE_LOW_HIGH, PRICE_HIGH_LOW, REVIEW, NEWEST }

final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0xff8921aa), Color(0xffDA44bb)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

final gradient = LinearGradient(
  colors: <Color>[Color(0xff8921aa), Color(0xffDA44bb)],
);

InputDecoration textFieldDecoration({String hint, IconData icon}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.sp),
      ),
    ),
    hintStyle: TextStyle(color: Colors.grey.shade800, fontSize: 14.sp),
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(vertical: 7.sp),
    prefixIcon: Icon(
      icon,
      color: Colors.grey,
    ),
  );
}

final textFieldStyle = TextStyle(fontSize: 14.sp, color: Colors.black);

final homeTextStyle = TextStyle(
  fontSize: 20.sp,
  color: Colors.grey.shade700,
  fontWeight: FontWeight.bold,
);

final buttonColor = Color(0xff8921aa);

final appNameHeading = Text(
  Strings.APP_NAME,
  style: GoogleFonts.dancingScript(
    textStyle: TextStyle(
      foreground: Paint()..shader = linearGradient,
      fontSize: 40.sp,
      fontWeight: FontWeight.bold,
    ),
  ),
);

final minPrice = [
  0,
  5000,
  10000,
  15000,
  20000,
  25000,
  30000,
  35000,
  40000,
  45000,
  50000
];
final maxPrice = [
  5000,
  10000,
  15000,
  20000,
  25000,
  30000,
  35000,
  40000,
  45000,
  50000,
  55000,
  60000,
  65000,
  70000
];
