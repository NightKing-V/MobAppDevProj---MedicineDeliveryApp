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
      home: MyDeliveries(),
    );
  }
}

class MyDeliveries extends StatefulWidget {
  @override
  _MyDeliveriesState createState() => _MyDeliveriesState();
}

class _MyDeliveriesState extends State<MyDeliveries> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delivery Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important_rounded),
            onPressed: () {
           
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    "Ongoing Deliveries",
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
                          NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var product = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: SizedBox(
                            width: double.infinity,
             
                            child: product['status'] == "delivering" || product['status'] == "deliverd"
                                ? ExpandedCard(
                                    firstName: product['userID']['firstName'],
                                    productId: product['product']['_id'],
                                    cost: product['cost'],
                                    qty: product['qty'],
                                    shipping: product['shipping'],
                                    status: product['status'],
                                    createdAt: product['createdAt'],
                                    sicon:Icon(Icons.check, color: Color.fromARGB(255, 15, 182, 0)),
                                    onDelete: () {
                                      setState(() {
                                        var productToRemove = snapshot.data![
                                            index]; 
                                        print(productToRemove['_id']);
                                        deleteOrderById(
                                            context, productToRemove['_id']);
                                        snapshot.data!.removeAt(index);
                                      });
                                    },
                                    onMove: (){
                                      completeOrder(context,
                                          snapshot.data![index]['_id']);
                                    },
                                  )
                                : Container(), 
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
