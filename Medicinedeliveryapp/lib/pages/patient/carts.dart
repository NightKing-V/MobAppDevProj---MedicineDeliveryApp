
import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/controllers/cartController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
   List<dynamic> cart = []; // Initialize empty cart

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  void fetchCartData() async {
    try {
      final results = await fetchCart(context); // Fetching cart data
      setState(() {
        cart = results;
      });
    } catch (e) {
      // Handle errors, e.g., show a message or log an error
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text('Cart',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
  centerTitle: true,
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        // Handle settings button press
      },
    ),
  ],
),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image.network(
                              "http://192.168.1.3:3000/uploads/Product/image_1712677119988.jpg"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Item: Elastic Bandage",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Quantity: 4",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
