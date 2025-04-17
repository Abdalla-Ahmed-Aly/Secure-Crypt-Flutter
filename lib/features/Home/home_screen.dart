import 'package:flutter/material.dart';
import 'package:secure_crypt/features/Home/tabs/CTR/ctr_tab.dart';
import 'package:secure_crypt/features/Home/tabs/Home/home_tab.dart';
import 'package:secure_crypt/features/Home/tabs/RSA/rsa_tab.dart';
import 'package:secure_crypt/features/Home/tabs/SHA-1/sha1_tab.dart';
import 'package:secure_crypt/utils/color_app.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> pageTab = [
    HomeTab(),
    Sha1Tab(),
    RsaTab(),
    CtrTab()
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; ///    412
    final height = MediaQuery.of(context).size.height; ///  917
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
          top: height * 0.02,
          bottom: height * 0.01,
        ),
        child: pageTab[selectedIndex]
      ),
    
      bottomNavigationBar: Container(
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
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorApp.primaryColor,
          showUnselectedLabels: false,
          showSelectedLabels: false,
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
          ? Column(
            children: [
              Text(text,
                      style: TextStyle(
                        color: ColorApp.primaryDarkColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
              Container(
                width: 50,
                height: 1,
                color: ColorApp.primaryDarkColor,
              )
            ],
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
