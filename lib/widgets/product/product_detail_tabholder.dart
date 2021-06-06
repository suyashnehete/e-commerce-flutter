import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsTabHolder extends StatefulWidget {
  final String description;
  final String warrantySummary;
  final String covered;
  final String notCovered;

  ProductDetailsTabHolder(
      {this.description, this.warrantySummary, this.covered, this.notCovered});

  @override
  _ProductDetailsTabHolderState createState() =>
      _ProductDetailsTabHolderState();
}

class _ProductDetailsTabHolderState extends State<ProductDetailsTabHolder>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              controller: _controller,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
              ),
              indicator: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(30.sp),
                ),
              ),
              tabs: [
                Tab(
                  text: Strings.DESCRIPTION,
                ),
                Tab(
                  text: Strings.WARRANTY,
                ),
              ],
            ),
            Container(
              width: 100.w,
              height: 250.sp,
              child: TabBarView(
                controller: _controller,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 30.sp,
                      left: 8.sp,
                      right: 8.sp,
                    ),
                    child: Column(
                      children: [
                        WarrantyCard(
                          title: Strings.WARRANTY_SUMMARY + " :",
                          value: widget.warrantySummary,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 7.sp),
                          height: 0.5.sp,
                          color: Colors.black,
                        ),
                        WarrantyCard(
                          title: Strings.COVERED_IN_WARRANTY + " :",
                          value: widget.covered,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 7.sp),
                          height: 0.5.sp,
                          color: Colors.black,
                        ),
                        WarrantyCard(
                          title: Strings.NOT_COVERED_IN_WARRANTY + " :",
                          value: widget.notCovered,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WarrantyCard extends StatelessWidget {
  final String title;
  final String value;

  WarrantyCard({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13.sp, color: Colors.black),
          ),
        )
      ],
    );
  }
}
