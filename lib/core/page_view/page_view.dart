import 'package:flutter/material.dart';
import 'package:secure_crypt/core/page_view/PageIndicator.dart';
import 'package:secure_crypt/core/page_view/page_view_class.dart';
import 'package:secure_crypt/core/page_view/page_view_details.dart';

class MyPageView extends StatefulWidget {
  static const routeName = '/MyPageView';

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> with TickerProviderStateMixin {
  late PageController _pageViewController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the PageController to manage the PageView
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed to free resources
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0ECE4), // Background color of the screen
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: <Widget>[
            // PageView widget for swiping through pages
            PageView(
              controller: _pageViewController,
              onPageChanged: _handlePageViewChanged, // Update page index on change
              children: <Widget>[
                PageViewDetails(PageViewClass(
                  image: 'splash',
                  text1: 'Secure Hash Algorithm',
                  text2:
                      "Converts data into a unique code to check for changes.",
                )),
                PageViewDetails(PageViewClass(
                  image: 'splash',
                  text1: 'RSA Algorithm',
                  text2:
                      'Secures data using a public and private key pair.',
                )),
                PageViewDetails(PageViewClass(
                  image: 'splash',
                  text1: 'CTR Mode',
                  text2: 'Encrypts data in blocks using a fast counter system.',
                )),
              ],
            ),
            // Page indicator at the bottom of the page
            Align(
              alignment: Alignment.bottomCenter,
              child: PageIndicator(
                pageController: _pageViewController,
                currentPageIndex: _currentPageIndex,
                onUpdateCurrentPageIndex: _updateCurrentPageIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Handle page changes in the PageView
  void _handlePageViewChanged(int currentPageIndex) {
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  // Update the page index when the user taps on the page indicator
  void _updateCurrentPageIndex(int index) {
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentPageIndex = index;
    });
  }
}
