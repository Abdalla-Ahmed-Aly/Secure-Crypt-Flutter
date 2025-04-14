import 'package:flutter/material.dart';
import 'package:secure_crypt/utils/color_app.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width; ///    412
    var height = MediaQuery.of(context).size.height; ///  917
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Cryptography Algorithms")
          ],
        ),
      ),

      bottomNavigationBar: Container(
        width: double.infinity,
        height: height * 0.069,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          )
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            selectedIndex = index;
            setState(() {});
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorApp.primaryColor,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          items: [
            customItemNavigateBar("Home", 0),
            customItemNavigateBar("SHA-1", 1),
            customItemNavigateBar("RSA", 2),
            customItemNavigateBar("CTR", 3),
          ]
        ),
      ),
    );
  }

  BottomNavigationBarItem customItemNavigateBar(String text, int index){
    return BottomNavigationBarItem(
      icon: selectedIndex == index
          ? Text(text,
        style: TextStyle(
          color: ColorApp.primaryDarkColor,
          fontWeight: FontWeight.w400,
          fontSize: 17,
          decoration: TextDecoration.underline,
          decorationColor: ColorApp.primaryDarkColor,
          decorationThickness: 1.9,
        ),
      )
          : Text(text,
        style: TextStyle(
            color: ColorApp.blackColor,
            fontWeight: FontWeight.w400,
            fontSize: 15,
        ),
      ),label: ""
    );
  }
}
