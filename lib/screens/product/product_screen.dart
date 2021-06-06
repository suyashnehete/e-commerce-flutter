import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/models/product_highlight_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/product_review_model.dart';
import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:e_commerce/widgets/custom_scaffold.dart';
import 'package:e_commerce/widgets/product/product_detail_tabholder.dart';
import 'package:e_commerce/widgets/product/product_details_commentbox.dart';
import 'package:e_commerce/widgets/product/product_details_header.dart';
import 'package:e_commerce/widgets/product/product_details_highlights.dart';
import 'package:e_commerce/widgets/product/product_details_offers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/helper/strings.dart';

class ProductScreen extends StatelessWidget {
  final int id;

  ProductScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: FutureBuilder<ProductModel>(
        future: API.getProduct(context, id: id),
        builder: (context, model) {
          if (model.hasData) {
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          FutureBuilder<List<String>>(
                            future: API.getProductImages(context,
                                id: model.data.id),
                            builder: (context, list) {
                              if (list.hasData) {
                                list.data.insert(0, model.data.image);
                                return ProductDetailsHeader(
                                  list: list.data,
                                  name: model.data.name,
                                  price: model.data.price,
                                  rating: model.data.rating,
                                  seller: model.data.soldBy,
                                  stock: model.data.stock,
                                  id: model.data.id,
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          SizedBox(
                            height: 3.sp,
                          ),
                          ProductDetailsOffers(),
                          SizedBox(
                            height: 3.sp,
                          ),
                          FutureBuilder<List<ProductHighlightModel>>(
                            future: API.getProductHighlights(context,
                                id: model.data.id),
                            builder: (context, list) {
                              if (list.hasData) {
                                if (list.data.length == 0) {
                                  return Container();
                                }
                                return ProductDetailsHighlight(
                                  lst: list.data,
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          SizedBox(
                            height: 3.sp,
                          ),
                          ProductDetailsTabHolder(
                            description: model.data.description,
                            covered: model.data.coveredInWarranty,
                            notCovered: model.data.notCoveredInWarranty,
                            warrantySummary: model.data.warrantySummary,
                          ),
                          SizedBox(
                            height: 3.sp,
                          ),
                          FutureBuilder<List<ProductReviewModel>>(
                            future: API.getProductReviews(context,
                                id: model.data.id),
                            builder: (context, list) {
                              if (list.hasData) {
                                if (list.data.length == 0) {
                                  return Container();
                                }
                                return ProductDetailCommentBox(
                                  comments: list.data,
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  model.data.stock < 1
                      ? SizedBox()
                      : Container(
                          width: 100.w,
                          height: 45.sp,
                          padding: EdgeInsets.symmetric(
                              vertical: 2.sp, horizontal: 15.sp),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.sp),
                                  ),
                                  border: Border.all(
                                    color: Colors.grey.shade800,
                                    width: 1.sp,
                                  ),
                                ),
                                child: IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.cartPlus,
                                    color: Colors.grey.shade800,
                                  ),
                                  onPressed: () async {
                                    if (!Provider.of<Data>(context,
                                            listen: false)
                                        .isAuthenticated) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                      );
                                      return;
                                    }
                                    await API.addCartItems(
                                        context, model.data.id, 1);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(Strings.PRODUCT_ADDED)));
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.sp),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (!Provider.of<Data>(context,
                                              listen: false)
                                          .isAuthenticated) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                        );
                                        return;
                                      }
                                      await API.addCartItems(
                                          context, model.data.id, 1);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text(Strings.PRODUCT_ADDED)));
                                    },
                                    child: Text(
                                      Strings.BUY_NOW,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              buttonColor),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(vertical: 9.sp)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
