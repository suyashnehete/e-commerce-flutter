import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:e_commerce/widgets/popup_widget.dart';
import 'package:e_commerce/widgets/price_filter_widget.dart';
import 'package:e_commerce/widgets/product/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductsScreen extends StatefulWidget {
  final String query;

  ProductsScreen({@required this.query});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isList = false;
  String query = "";

  @override
  void initState() {
    super.initState();
    query = widget.query;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 100.w,
              height: 40.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade800,
                    offset: Offset(0.0, 1),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SortPopup(
                      onSelected: (val) {
                        setState(() {
                          switch (val) {
                            case SortMenuItems.FEATURED:
                              query += "";
                              break;
                            case SortMenuItems.NEWEST:
                              query += "&ordering=-id";
                              break;
                            case SortMenuItems.REVIEW:
                              query += "&ordering=-rating";
                              break;
                            case SortMenuItems.PRICE_HIGH_LOW:
                              query += "&ordering=-price";
                              break;
                            case SortMenuItems.PRICE_LOW_HIGH:
                              query += "&ordering=price";
                              break;
                          }
                        });
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade800,
                    width: 0.5.sp,
                  ),
                  Expanded(
                    flex: 2,
                    child: TextButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => PriceFilter(
                            onMaxChange: (index) {},
                            onMinChange: (index) {},
                          ),
                        );
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.filter,
                        color: buttonColor,
                      ),
                      label: Text(
                        Strings.FILTER,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: buttonColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade800,
                    width: 0.5.sp,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          isList = !isList;
                        });
                      },
                      icon: FaIcon(
                        isList ? Icons.grid_on : FontAwesomeIcons.list,
                        color: buttonColor,
                      ),
                      label: Text(
                        "",
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 5.sp),
                child: FutureBuilder<List<ProductModel>>(
                  future: API.getAllProducts(context, query: query),
                  builder: (context, list) {
                    if (list.hasData) {
                      if (list.data.length == 0) {
                        return Center(
                          child: Text(
                            "No Products Found",
                            style: homeTextStyle,
                          ),
                        );
                      }
                      return isList
                          ? ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 10.sp),
                              itemCount: list.data.length,
                              itemBuilder: (context, index) {
                                return ProductTile(
                                  model: list.data[index],
                                );
                              },
                            )
                          : GridView.builder(
                              padding: EdgeInsets.all(10.sp),
                              itemCount: list.data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5.sp,
                                mainAxisSpacing: 10.sp,
                                mainAxisExtent: 155.sp,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                    child: ProductWidget(
                                  width: 50.w,
                                  model: list.data[index],
                                ));
                              },
                            );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
