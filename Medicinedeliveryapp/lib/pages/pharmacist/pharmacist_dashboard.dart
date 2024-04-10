import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/components/card_button.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/product_orders.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/product_store.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PharmacistDashboard(),
    );
  }
}

class PharmacistDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to Pharmacy App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important_rounded),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
        // Add padding to the top and bottom of the AppBar
        toolbarHeight: kToolbarHeight + 20.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0), // Padding at the top
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    "Dashboard",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              // Constrain the height of the GridView
              Container(
                height: 500, // Specify a fixed height for the GridView
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio:
                      3 / 2, // Adjust the size ratio of the grid items
                  crossAxisSpacing: 10, // Horizontal space between items
                  mainAxisSpacing: 10, // Vertical space between items
                  shrinkWrap:
                      true, // Important to let GridView know to constrain its content
                  physics:
                      NeverScrollableScrollPhysics(), // To prevent GridView from scrolling
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CardButton(
                        title: "My Products",
                        icon: Icons.inventory, // Use Icon widget directly
                        color: Colors.green,
                        onPressed: () {
                          print("Navigating to PharmacistDashboard");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProducts()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CardButton(
                        title: "My Orders",
                        icon: Icons.list_alt, // Use Icon widget directly
                        color: Colors.blue,
                        onPressed: () {
                          print("Navigating to PharmacistDashboard");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrders()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CardButton(
                        title: "My Deliveries",
                        icon: Icons.local_shipping, // Use Icon widget directly
                        color: Colors.orange,
                        onPressed: () {
                          // Action for My Deliveries
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CardButton(
                        title: "Patient Chats",
                        icon: Icons.chat, // Use Icon widget directly
                        color: Colors.pink,
                        onPressed: () {
                          // Action for Patient Chats
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Add more widgets as needed
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Handle home button press
              },
            ),
            IconButton(
              icon: Icon(Icons.library_books_rounded),
              onPressed: () {
                // Handle search button press
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
