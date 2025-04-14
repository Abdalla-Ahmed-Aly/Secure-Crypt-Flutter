import 'package:flutter/material.dart';
import 'package:secure_crypt/core/page_view/page_view.dart';
import 'package:secure_crypt/features/Home/home_screen.dart';
import 'package:secure_crypt/core/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
              SplashScreen.routeName: (_) => SplashScreen(),
              HomeScreen.routeName: (_) => HomeScreen(),
              MyPageView.routeName: (_) => MyPageView(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}