import 'package:flutter/material.dart';
import 'package:secure_crypt/core/page_view/page_view.dart';
import 'package:secure_crypt/features/Home/home_screen.dart';
import 'package:secure_crypt/core/splash.dart';
import 'package:secure_crypt/utils/color_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "encryption",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorApp.colorBg
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
              SplashScreen.routeName: (_) => SplashScreen(),
              HomeScreen.routeName: (_) => HomeScreen(),
              MyPageView.routeName: (_) => MyPageView(),
      },
    );
  }
}