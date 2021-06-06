import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class SortPopup extends StatelessWidget {
  final Function onSelected;

  SortPopup({this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortMenuItems>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.sp),
        ),
      ),
      onSelected: onSelected,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.sort,
            color: buttonColor,
          ),
          SizedBox(
            width: 5.sp,
          ),
          Text(
            Strings.SORT,
            style: TextStyle(
              fontSize: 14.sp,
              color: buttonColor,
            ),
          ),
        ],
      ),
      itemBuilder: (context) => <PopupMenuEntry<SortMenuItems>>[
        const PopupMenuItem<SortMenuItems>(
          value: SortMenuItems.FEATURED,
          child: Text(
            Strings.FEATURED,
          ),
        ),
        const PopupMenuItem<SortMenuItems>(
          value: SortMenuItems.PRICE_LOW_HIGH,
          child: Text(Strings.PRICE_LOW_HIGH),
        ),
        const PopupMenuItem<SortMenuItems>(
          value: SortMenuItems.PRICE_HIGH_LOW,
          child: Text(Strings.PRICE_HIGH_LOW),
        ),
        const PopupMenuItem<SortMenuItems>(
          value: SortMenuItems.REVIEW,
          child: Text(Strings.AVG_REVIEW),
        ),
        const PopupMenuItem<SortMenuItems>(
          value: SortMenuItems.NEWEST,
          child: Text(Strings.NEWEST),
        ),
      ],
    );
  }
}
