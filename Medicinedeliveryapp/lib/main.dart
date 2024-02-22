import 'dart:async';
import 'package:flutter/material.dart';
import 'loginpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool loadingIndicator = true;

  @override
  void initState() {
    super.initState();
    // After 8 seconds, navigate to the login page
    Timer(Duration(seconds: 8), () {
      setState(() {
        loadingIndicator = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Color customColor = Color.fromARGB(255, 80, 217, 215);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image at the center
            Image.asset(
              'assets/laptop.png',
              width: 300.0, // Adjust the width as needed
              height: 300.0, // Adjust the height as needed
            ),
            // Loading circle below the image
            SizedBox(height: 20.0),
            Container(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                strokeWidth: 5.0,
                valueColor: AlwaysStoppedAnimation<Color>(customColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
