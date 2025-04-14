
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
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xffF0ECE4),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: <Widget>[
            
            PageView(
              controller: _pageViewController,
              onPageChanged: _handlePageViewChanged,
              children: <Widget>[
                PageViewDetails(PageViewClass(
                  image: 'onbordingHeader',
                  text1: 'Secure Hash Algorithm ',
                  text2:
                      "Converts data into a unique code to check for changes.",
                )),
                PageViewDetails(PageViewClass(
                  image: 'onbordingHeader',
                  text1: 'RSA Algorithm',
                  text2:
                      'Secures data using a public and private key pair.',
                )),
                PageViewDetails(PageViewClass(
                    image: 'onbordingHeader',
                    text1: 'CTR Mode',
                    text2:
                        'Encrypts data in blocks using a fast counter system.')),
               
               
              ],
            ),
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

  Widget _buildPage(BuildContext context, String imagePath, String text) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.only(top: 79),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: MediaQuery.sizeOf(context).height * 0.39,
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            text,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: Color(0xff9B745B),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

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
