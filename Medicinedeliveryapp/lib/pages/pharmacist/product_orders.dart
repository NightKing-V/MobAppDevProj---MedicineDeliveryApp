import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/components/pharmacy_order_list.dart';
import 'package:medicinedeliveryapp/controllers/pharmacist_orders.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyOrders(),
    );
  }
}

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  // This function simulates fetching data from a network.

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
        toolbarHeight: kToolbarHeight + 20.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0),
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
                    "My Orders",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              FutureBuilder<List<dynamic>>(
                future: fetchAllOrdersByPharmacy(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics:
                          NeverScrollableScrollPhysics(), // to disable ListView's own scrolling
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var product = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ExpandedCard(
                              firstName: product['userID']['firstName'],
                              productId: product['product']['_id'],
                              cost: product['cost'],
                              qty: product['qty'],
                              shipping: product['shipping'],
                              status: product['status'],
                              createdAt: product['createdAt'],
                              onDelete: () {
                                setState(() {
                                  var productToRemove = snapshot.data![
                                      index]; // Capture the product before removal
                                  print(productToRemove['_id']);
                                  deleteOrderById(
                                      context, productToRemove['_id']);
                                  snapshot.data!.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.library_books_rounded), onPressed: () {}),
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
