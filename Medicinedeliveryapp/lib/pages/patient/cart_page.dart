import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/controllers/cartController.dart';
import 'package:medicinedeliveryapp/models/cart_model.dart';
import 'package:medicinedeliveryapp/pages/patient/patient_store.dart';
import 'package:medicinedeliveryapp/pages/patient/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CartGrid(),
    );
  }
}

class CartGrid extends StatefulWidget {
  const CartGrid({super.key});

  @override
  State<CartGrid> createState() => _CartGridState();
}

class _CartGridState extends State<CartGrid> {
  late Future<List<Cart>> futureCart;
  @override
  void initState() {
    super.initState();
    futureCart = getCart(context) as Future<List<Cart>>;
  }

  Future<void> deleteItem(String itemId) async {
    await deleteFromCart(context, itemId);
    setState(() {
      futureCart = getCart(context)
          as Future<List<Cart>>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      
      body: Center(
        child: FutureBuilder<List<Cart>>(
          future: futureCart,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final allItems =
                  snapshot.data!.expand((cart) => cart.items).toList();

              return ListView.builder(
                itemCount: allItems.length,
                itemBuilder: (context, index) {
                  final item = allItems[index];
                  return ListTile(
                    title: Text(item.product.name),
                    subtitle: Text(
                        'Price: LKR ${item.product.price * item.quantity}, Quantity: ${item.quantity}'),
                    leading: item.product.images.isNotEmpty
                        ? Image.network(item.product.images.first,
                            width: 50, height: 50)
                        : null,
                    trailing: IconButton(
                      onPressed: () {
                        deleteItem(item.product.id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text("No data available");
            }
          },
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
