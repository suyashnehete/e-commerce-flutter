import 'package:e_commerce/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomOutlineButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  CustomOutlineButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
          vertical: 10.sp,
        )),
        side: MaterialStateProperty.all(
          BorderSide(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.sp),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CustomGradientButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  CustomGradientButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.symmetric(
        vertical: 10.sp,
        horizontal: 10.sp,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 7.sp,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade800,
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(30.sp),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final text;
  final void Function() onPressed;

  CustomTextButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.sp),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
