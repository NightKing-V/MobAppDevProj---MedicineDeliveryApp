import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/pages/patient/patient__dashbaord.dart';
import '../splash/logsignsplash.dart';
import 'package:medicinedeliveryapp/controllers/loginController.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // Define the custom color
    Color customColor = Color.fromARGB(255, 25, 154, 142);
    // Define a TextEditingController
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        // Center the content vertically
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SlideTransition(
              position: _offsetAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Custom Heading "Login" centered horizontally
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  // Email Textbox
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Password Textbox with visibility toggle
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          // Implement toggle password visibility logic
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Implement forgot password logic or navigate to a link
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: customColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Login Button with corner radius and custom color
                  ElevatedButton(
                    onPressed: () async {
                      LoginResult result = await loginAndGetAccessToken(context,
                          usernameController.text, passwordController.text);

                      if (result.success) {
                        print(
                            'Login successful, role: ${result.role}, accessToken: ${result.accessToken}');
                        if (result.role == "patient") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      } else {
                        print('Login failed, error: ${result.errorMessage}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid data. Please try again.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        usernameController.clear();
                        passwordController.clear();
                      }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  // Don't have an account? Sign up
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreenSignUp()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: customColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
