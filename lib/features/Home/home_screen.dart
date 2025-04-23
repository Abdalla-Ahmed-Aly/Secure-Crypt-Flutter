import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_crypt/core/Provides/navigate_tabs_provider.dart';
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
  // متغير لرفع الـ state
  var navigateTabProvider;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    navigateTabProvider = Provider.of<NavigateTabsProvider>(context);

    return SafeArea(
      bottom: false,
      child: Scaffold(
        // استخدام IndexedStack لعرض التابات بناءً على currentIndex
        body: Padding(
          padding: EdgeInsets.only(
            left: width * 0.05,
            right: width * 0.05,
            top: height * 0.02,
            bottom: height * 0.01,
          ),
          child: IndexedStack(
            index: navigateTabProvider.currentIndex, 
            children: [
              HomeTab(),
              Sha1Tab(),
              RsaTab(),
              CtrTab(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigateTabProvider.currentIndex,
          onTap: (index) {
            if (index == navigateTabProvider.currentIndex) return;
            navigateTabProvider.currentIndex = index;
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
          ],
        ),
      ),
    );
  }

  // تخصيص عناصر شريط التنقل
  BottomNavigationBarItem customItemNavigateBar(String text, int index) {
    return BottomNavigationBarItem(
      icon: navigateTabProvider.currentIndex == index
          ? Column(
              children: [
                Text(
                  text,
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
                ),
              ],
            )
          : Text(
              text,
              style: TextStyle(
                color: ColorApp.blackColor,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
      label: "",
    );
  }
}
