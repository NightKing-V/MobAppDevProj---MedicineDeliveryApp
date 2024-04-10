import 'dart:async';
import 'package:flutter/material.dart';
import 'pages/authentication/login_page.dart';
import 'package:provider/provider.dart';
import 'package:medicinedeliveryapp/models/authModel.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => AuthModel(),
      child: MyApp(),
      )
      );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
    Timer(Duration(seconds: 1), () {
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
