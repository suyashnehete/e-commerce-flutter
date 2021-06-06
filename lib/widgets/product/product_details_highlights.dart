import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/product_highlight_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsHighlight extends StatefulWidget {
  final List<ProductHighlightModel> lst;

  ProductDetailsHighlight({this.lst});

  @override
  _ProductDetailsHighlightState createState() =>
      _ProductDetailsHighlightState();
}

class _ProductDetailsHighlightState extends State<ProductDetailsHighlight> {
  bool isExpanded = false;

  int getCount(isExpanded) {
    if (isExpanded) return widget.lst.length;
    if (widget.lst.length < 4) {
      return widget.lst.length;
    }
    return 3;
  }

  double getHeight(isExpanded) {
    if (isExpanded) return widget.lst.length * 500.sp;
    return 3 * 500.sp - 400.sp;
  }

  List<Widget> lst1 = [];

  List<Widget> getList(isExpanded) {
    if (isExpanded) {
      return lst1;
    } else {
      List<Widget> lst =
          lst1.sublist(0, widget.lst.length < 4 ? widget.lst.length : 3);
      lst.add(
        Center(
          child: IconButton(
            onPressed: () {
              expand();
            },
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: buttonColor,
              size: 30.sp,
            ),
          ),
        ),
      );
      return lst;
    }
  }

  void expand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.lst.length; i++) {
      lst1.add(
        HighlightCard(
          title: widget.lst[i].title,
          description: widget.lst[i].description,
          image: widget.lst[i].image,
          divider: i != widget.lst.length - 1,
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Container(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.HIGHLIGHTS,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              child: Column(
                children: getList(isExpanded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HighlightCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool divider;

  HighlightCard({this.title, this.description, this.image, this.divider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.network(
            image,
            width: 100.w,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 4.sp,
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black,
            ),
          ),
          divider
              ? Container(
                  margin:
                      EdgeInsets.only(top: 10.sp, left: 12.sp, right: 12.sp),
                  height: 0.5.sp,
                  color: Colors.grey.shade500,
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
