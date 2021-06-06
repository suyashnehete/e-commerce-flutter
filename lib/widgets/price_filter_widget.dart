import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PriceFilter extends StatefulWidget {
  final Function(int) onMinChange;
  final Function(int) onMaxChange;

  PriceFilter({
    this.onMinChange,
    this.onMaxChange,
  });

  @override
  _PriceFilterState createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  FixedExtentScrollController minController;
  FixedExtentScrollController maxController;

  @override
  void initState() {
    super.initState();
    setState(() {
      maxPrice.clear();
      maxPrice.add(5000);
      for (int i = 1; i < 10; i++) {
        maxPrice.add(maxPrice[i - 1] + 5000);
      }
    });
    maxController = FixedExtentScrollController(initialItem: 10);
    minController = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Strings.PRICE_RANGE,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 5.sp,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CupertinoPicker.builder(
                    itemExtent: 42.sp,
                    childCount: minPrice.length,
                    useMagnifier: true,
                    scrollController: minController,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        maxPrice.clear();
                        maxPrice
                            .add(minPrice[minController.selectedItem] + 5000);
                        for (int i = 1; i < 10; i++) {
                          maxPrice.add(maxPrice[i - 1] + 5000);
                        }
                      });
                      widget.onMinChange(index);
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text("${Strings.RS}${minPrice[index]}"),
                      );
                    },
                  ),
                ),
                Text(
                  "to",
                  style: TextStyle(fontSize: 14.sp),
                ),
                Expanded(
                  child: CupertinoPicker.builder(
                    itemExtent: 42.sp,
                    childCount: maxPrice.length,
                    onSelectedItemChanged: widget.onMaxChange,
                    scrollController: maxController,
                    itemBuilder: (context, index) {
                      if (index == maxPrice.length - 1) {
                        return Center(
                          child: Text("${Strings.RS}${maxPrice[index]}+"),
                        );
                      }
                      return Center(
                        child: Text("${Strings.RS}${maxPrice[index]}"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
