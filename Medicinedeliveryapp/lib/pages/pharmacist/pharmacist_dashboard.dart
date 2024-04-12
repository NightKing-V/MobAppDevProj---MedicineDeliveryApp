import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/components/card_button.dart';
import 'package:medicinedeliveryapp/models/authModel.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/prescriptions.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/product_deliveries.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/product_orders.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/product_store.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/profile.dart';
import 'package:provider/provider.dart';

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

String capitalize(String s) {
  if (s.isEmpty) return "";
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}

class PharmacistDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Medic',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important_rounded),
            onPressed: () {
              // Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => Product()),
              //               );
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
              SizedBox(height: 10.0), // Padding at the top
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:30,right:30),
                      child: Container(
                        width: MediaQuery.of(context).size.width-60,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors
                                .blue, // Specify the background color for the container
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5.0, left: 20),
                                  child: Text(
                                    "Welcome !",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5.0, left: 20),
                                  child: Text(
                                    capitalize("${Provider.of<AuthModel>(context).username}"),
                                    
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.amber,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Icon(
                                Icons.medical_information,
                                size: 50,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
              // Constrain the height of the GridView
              Container(
                height: 350, // Specify a fixed height for the GridView
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 30,right: 30),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio:
                        3 / 2, // Adjust the size ratio of the grid items
                    crossAxisSpacing: 5, // Horizontal space between items
                    mainAxisSpacing: 5, // Vertical space between items
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
                                  builder: (context) => MyProduct()),
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
                          icon:
                              Icons.local_shipping, // Use Icon widget directly
                          color: Colors.orange,
                          onPressed: () {
                            print("Navigating to PharmacistDashboard");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyDeliveries()),
                            );
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
                            print("Navigating to PharmacistDashboard");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrescriptionsPage()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text("Pending Orders : 8",style: TextStyle(fontSize: 15,color: Colors.white),)),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text("Delivery in Process : 8",style: TextStyle(fontSize: 15,color: Colors.white),)),
                ),
              ],)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home,color: Colors.green,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PharmacistDashboard()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.library_books_rounded,color: Colors.green,),
              onPressed: () {
                // Handle search button press
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle,color: Colors.green,),
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
