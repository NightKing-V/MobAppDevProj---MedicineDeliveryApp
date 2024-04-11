import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/models/authModel.dart';
import 'package:medicinedeliveryapp/pages/authentication/login_page.dart';
import 'package:medicinedeliveryapp/pages/patient/cart_page.dart';
import 'package:medicinedeliveryapp/pages/patient/patient_store.dart';
import 'package:provider/provider.dart';
// import 'package:medicinedeliveryapp/pages/pharmacist/product_store.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://placeimg.com/640/480/people'),
                radius: 50.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              Provider.of<AuthModel>(context).username, // Replace with username
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Align content to the left
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartGrid()),
                          );
                        },
                        icon: Icon(Icons.shopping_cart),
                        label: Text("Cart"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 228, 228, 228),
                          minimumSize: Size(150.0, 40.0),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0), // Spacing between button and text
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartGrid()),
                          );
                        },
                        icon: Icon(Icons.payment),
                        label: Text("Payment"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 228, 228, 228),
                          minimumSize: Size(150.0, 40.0),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0), // Spacing between button and text
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartGrid()),
                          );
                        },
                        icon: Icon(Icons.favorite),
                        label: Text("Favourites"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 228, 228, 228),
                          minimumSize: Size(150.0, 40.0),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0), // Spacing between button and text
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        icon: Icon(Icons.logout),
                        label: Text("Logout"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 228, 228, 228),
                          minimumSize: Size(150.0, 40.0),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0), // Spacing between button and text
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Color(0xFF199A8E),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.medication,
                color: Color(0xFF199A8E),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductStore()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Color(0xFF199A8E),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                ); // Handle settings button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
