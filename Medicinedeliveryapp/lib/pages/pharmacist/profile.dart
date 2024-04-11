import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/models/authModel.dart';
import 'package:medicinedeliveryapp/pages/patient/cart_page.dart';
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
              padding: const EdgeInsets.only(left: 140, right: 100),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Align content to the left
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
                          minimumSize:
                              Size(150.0, 40.0),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0), // Spacing between button and text
                    ],
                  ),
                 Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Align content to the left
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => CartPages()),
                          // );
                        },
                        icon: Icon(Icons.payment),
                        label: Text("Payment"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 228, 228, 228),
                          minimumSize:
                              Size(150.0, 40.0),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0), // Spacing between button and text
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Align content to the left
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
                          minimumSize:
                              Size(150.0, 40.0),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0), // Spacing between button and text
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Align content to the left
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartGrid()),
                          );
                        },
                        icon: Icon(Icons.logout),
                        label: Text("Logout"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 228, 228, 228),
                          minimumSize:
                              Size(150.0, 40.0),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(18.0),
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
    );
  }
}
