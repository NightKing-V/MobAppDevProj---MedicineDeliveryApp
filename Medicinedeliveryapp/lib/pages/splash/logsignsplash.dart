//import 'dart:async';
import 'package:flutter/material.dart';
import '../authentication/signup_page.dart';

class SplashScreenSignUp extends StatefulWidget {
  @override
  _SplashScreenSignUpState createState() => _SplashScreenSignUpState();
}

class _SplashScreenSignUpState extends State<SplashScreenSignUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 5,
    ).animate(_controller);

    _controller.forward();

    // Navigating to the login page when the rotation animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _rotationAnimation,
              child: Image.asset(
                'assets/pharmacy.png', // Replace with your actual icon path
                width: 70.0,
                height: 70.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
