import 'package:e_commerce/helper/api_helper.dart';
import 'package:e_commerce/helper/data.dart';
import 'package:e_commerce/helper/strings.dart';
import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Wishlist extends StatefulWidget {
  final int id;

  Wishlist({this.id});

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  var icon = FontAwesomeIcons.heart;

  @override
  Widget build(BuildContext context) {
    return Provider.of<Data>(context, listen: false).isAuthenticated
        ? FutureBuilder<int>(
            future: API.checkWishlist(context, productId: widget.id),
            builder: (context, data) {
              if (data.hasData) {
                if (data.data != 0) {
                  icon = FontAwesomeIcons.solidHeart;
                } else {
                  icon = FontAwesomeIcons.heart;
                }
                return GestureDetector(
                  child: FaIcon(
                    icon,
                    color: Colors.red,
                    size: 15.sp,
                  ),
                  onTap: () {
                    setState(() {
                      if (icon == FontAwesomeIcons.heart) {
                        icon = FontAwesomeIcons.solidHeart;
                        API.addToWishlist(context, productId: widget.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(Strings.ADDED_TO_WISHLIST)));
                      } else {
                        icon = FontAwesomeIcons.heart;
                        API.removeWishlist(context, wishlistId: data.data);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(Strings.REMOVED_FROM_WISHLIST)));
                      }
                    });
                  },
                );
              }
              return FaIcon(
                FontAwesomeIcons.heart,
                color: Colors.red,
                size: 15.sp,
              );
            },
          )
        : GestureDetector(
            child: FaIcon(
              FontAwesomeIcons.heart,
              color: Colors.red,
              size: 15.sp,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          );
  }
}
