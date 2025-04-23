import 'package:flutter/material.dart';
import 'package:secure_crypt/core/page_view/page_view_class.dart';

class PageViewDetails extends StatelessWidget {
  final PageViewClass pageViewclass;

  PageViewDetails(this.pageViewclass);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Hero(
            tag: 'image-${pageViewclass.image}', 
            child: Image.asset(
              'assets/images/${pageViewclass.image}.png',
              height: MediaQuery.of(context).size.height * 0.3,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 80),
          Text(
            pageViewclass.text1,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 28,
              color: Color(0xff9B745B),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Text(
            pageViewclass.text2,
            style: TextStyle(
              color: Color(0xff2E211C),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
