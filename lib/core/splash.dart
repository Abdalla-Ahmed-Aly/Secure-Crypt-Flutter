import 'dart:async';
import 'package:flutter/material.dart';
import 'package:secure_crypt/core/page_view/page_view.dart';
import 'package:secure_crypt/features/Home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _brandingController;
  late Animation<Offset> _brandingAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _textController;
  late Animation<double> _textOpacityAnimation;

  @override
  void initState() {
    super.initState();

    // Branding Slide Animation (Slides from bottom)
    _brandingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _brandingAnimation = Tween<Offset>(begin: Offset(0.0, 1.5), end: Offset.zero)
        .animate(CurvedAnimation(parent: _brandingController, curve: Curves.easeOut));

    // Pulse Animation for splash.png (Zoom effect)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Text Fade-In Animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    // Trigger animations after some delay
    Timer(const Duration(milliseconds: 1200), () {
      _brandingController.forward();
      _textController.forward();
    });

    // Navigate to the next screen after 4 seconds
    Timer(const Duration(seconds: 4), () {
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
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0ECE4), // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centering the content vertically
          children: [
            // Space before the splash image
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),

            // Splash Image with Pulse effect (Zoom in/out)
            ScaleTransition(
              scale: _pulseAnimation,
              child: Image.asset('assets/images/splash.png', width: 250),
            ),

            // Space before the branding image
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),

            // Branding Image with Slide effect (Slide in from bottom)
            SlideTransition(
              position: _brandingAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/nctu.png', width: 50),
                  const SizedBox(width: 10),
                  FadeTransition(
                    opacity: _textOpacityAnimation,
                    child: const Text(
                      'University Project',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A4A4A),
                      ),
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
