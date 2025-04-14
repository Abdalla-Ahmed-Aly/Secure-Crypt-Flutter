import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "فكك من الصفحه دي",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
