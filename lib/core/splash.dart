import 'dart:async';
import 'package:flutter/material.dart';
import 'package:secure_crypt/core/page_view/page_view.dart';
import 'package:secure_crypt/features/Home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _brandingController;
  late Animation<Offset> _brandingAnimation;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Branding Slide from bottom
    _brandingController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _brandingAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _brandingController, curve: Curves.easeOut),
    );

    // Pulse Animation for splash.png
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    Timer(Duration(milliseconds: 1200), () {
      _brandingController.forward();
    });

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyPageView()),
      );
    });
  }

  @override
  void dispose() {
    _brandingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0ECE4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 250),

            // Splash Image with Pulse only (no slide)
            ScaleTransition(
              scale: _pulseAnimation,
              child: Image.asset('assets/images/splash.png', width: 250),
            ),

            SizedBox(height: 200),

            // Branding Image - Slide from bottom
            SlideTransition(
              position: _brandingAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/nctu.png', width: 50),
                  SizedBox(width: 10),
                  Text(
                    'University Project',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
