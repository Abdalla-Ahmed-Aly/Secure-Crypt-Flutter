import 'package:flutter/material.dart';
import 'package:secure_crypt/features/Home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  PageIndicator({
    required this.pageController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
  });

  final int currentPageIndex;
  final PageController pageController;
  final void Function(int) onUpdateCurrentPageIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
              pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            icon: Visibility(
              visible: currentPageIndex > 0,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xff9B745B),
              ),
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: WormEffect(
              dotHeight: 15.0,
              dotWidth: 15.0,
              type: WormType.normal,
              activeDotColor: Color(0xff9B745B),
              dotColor: Colors.grey,
            ),
          ),
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () async {
              if (currentPageIndex == 2) {
                Navigator.popAndPushNamed(context, HomeScreen.routeName);
                await navigateAndSave();
              } else {
                onUpdateCurrentPageIndex(currentPageIndex + 1);
                pageController.nextPage(
                  duration: Duration(milliseconds: 0),
                  curve: Curves.easeIn,
                );
              }
            },
            icon:
                currentPageIndex == 2
                    ? Text(
                      'Finish',
                      style: TextStyle(fontSize: 20, color: Color(0xff9B745B)),
                    )
                    : Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xff9B745B),
                    ),
          ),
        ],
      ),
    );
  }
}

Future<void> navigateAndSave() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sharedPref.setBool('introscreen', true);
}
