import 'package:e_commerce/helper/constants.dart';
import 'package:e_commerce/screens/home/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'helper/data.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Data(),
      builder: (context, widget) {
        return Sizer(
          builder: (context, orientation, screenType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData().copyWith(
                accentColor: buttonColor,
              ),
              home: SplashScreen(),
            );
          },
        );
      },
    ),
  );
}
