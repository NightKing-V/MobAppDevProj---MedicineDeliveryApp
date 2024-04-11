import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/components/pharmacy_product_list.dart';
import 'package:medicinedeliveryapp/controllers/pharmacist_products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyProducts(),
    );
  }
}

class MyProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Inventory',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
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
              // Add more padding between the search bar and app bar
              SizedBox(height: 20.0),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    "My Products",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              Center(
                child: FutureBuilder<List<dynamic>>(
                  future: fetchAllProductsByPharmacy(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // Extract your data into a variable for ease of access
                      final List<dynamic> data = snapshot.data!;

                      // Iterate over the data and create a widget for each item
                      List<Widget> productList = data.map((product) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ExpandedCard(
                              imageUrl: product['images'][0],
                              name: product['name'],
                              description: product['description'],
                              company: product[
                                  'manufacturer'], // Assuming this matches your data structure
                              expiredate:
                                  product['expiryDate'], // Corrected field name
                              onDelete: () {
                                // Handle delete button press
                              },
                            ),
                          ),
                        );
                      }).toList();

                      // Use a Column to display all product widgets. You might need to wrap this with a SingleChildScrollView for scrolling.
                      return SingleChildScrollView(
                        child: Column(
                          children: productList,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // Handle error state
                      return Text('Error: ${snapshot.error}');
                    }
                    // Show a loading indicator while waiting for the data
                    return CircularProgressIndicator();
                  },
                ),
              ),

              //ProductList(),
              // Text(Provider.of<AuthModel>(context).accessToken), //access token
              // Add more widgets as needed
              // For example, you can add more Text, Image, or other widgets here
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
                // Handle settings button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
