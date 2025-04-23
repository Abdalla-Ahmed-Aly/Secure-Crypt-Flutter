import 'package:flutter/material.dart';
import 'package:secure_crypt/features/Home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  final int currentPageIndex;
  final PageController pageController;
  final void Function(int) onUpdateCurrentPageIndex;

  // Constructor for PageIndicator
  PageIndicator({
    required this.pageController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
  });

  // Define color and styles for reuse
  static const Color activeDotColor = Color(0xff9B745B);
  static const Color iconColor = Color(0xff9B745B);
  static const Color defaultDotColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Back navigation button
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex > 0) {
                onUpdateCurrentPageIndex(currentPageIndex - 1);
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            icon: Visibility(
              visible: currentPageIndex > 0,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: iconColor,
              ),
            ),
          ),

          // Page indicator using SmoothPageIndicator
          SmoothPageIndicator(
            controller: pageController,
            count: 3, // Number of pages in the view
            effect: WormEffect(
              dotHeight: 15.0,
              dotWidth: 15.0,
              type: WormType.normal,
              activeDotColor: activeDotColor,
              dotColor: defaultDotColor,
            ),
          ),

          // Forward navigation button or "Finish" button on last page
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () async {
              if (currentPageIndex == 2) {
                // Navigate to Home screen and save the 'introscreen' state
                Navigator.popAndPushNamed(context, HomeScreen.routeName);
                await _navigateAndSave();
              } else {
                onUpdateCurrentPageIndex(currentPageIndex + 1);
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            },
            icon: currentPageIndex == 2
                ? Text(
                    'Finish',
                    style: TextStyle(fontSize: 20, color: iconColor),
                  )
                : Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: iconColor,
                  ),
          ),
        ],
      ),
    );
  }

  // Save the introduction screen status in SharedPreferences
  Future<void> _navigateAndSave() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool('introscreen', true);
  }
}
