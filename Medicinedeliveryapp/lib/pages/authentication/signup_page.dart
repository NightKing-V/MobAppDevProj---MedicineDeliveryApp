import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../splash/tncsplash.dart';
import 'pharmacysignup.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  DateTime? _selectedDate;
  bool _agreedToTerms = false;

  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  int _selectedDay = DateTime.now().day;
  String _selectedUserType = "Patient";

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

  void handleSignUp() {
    if (_selectedUserType == "Pharmacy") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterPharmacyPage()),
      );
    } else {
      showDataAddedSnackbar();
    }
  }

  void showDataAddedSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data added!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color customColor = Color.fromARGB(255, 25, 154, 142);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: customColor,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SlideTransition(
              position: _offsetAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  DropdownButtonFormField<String>(
                    value: _selectedUserType,
                    items: [
                      DropdownMenuItem<String>(
                        value: "Patient",
                        child: Text('Patient'),
                      ),
                      DropdownMenuItem<String>(
                        value: "Pharmacy",
                        child: Text('Pharmacy'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedUserType = value!;
                      });
                    },
                  ),
                  SizedBox(height: 40.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Date of Birth:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: CupertinoPicker(
                            itemExtent: 40.0,
                            onSelectedItemChanged: (int index) {
                              setState(() {
                                _selectedYear = DateTime.now().year + index;
                              });
                            },
                            children: List.generate(100, (index) {
                              return Center(
                                child: Text(
                                  '${DateTime.now().year + index}',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: CupertinoPicker(
                            itemExtent: 40.0,
                            onSelectedItemChanged: (int index) {
                              setState(() {
                                _selectedMonth = index + 1;
                              });
                            },
                            children: List.generate(12, (index) {
                              return Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: CupertinoPicker(
                            itemExtent: 40.0,
                            onSelectedItemChanged: (int index) {
                              setState(() {
                                _selectedDay = index + 1;
                              });
                            },
                            children: List.generate(31, (index) {
                              return Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            _agreedToTerms = value!;
                          });
                        },
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to the Terms and Conditions page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => tncsplash(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'I agree to the',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              Text(
                                ' Terms and condition',
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
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      // textStyle:
                      //     TextStyle(color: Colors.white), // Set the font color
                    ),
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
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
    home: SignUpPage(),
  ));
}
