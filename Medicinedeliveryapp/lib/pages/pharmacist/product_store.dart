import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/components/pharmacy_product_list.dart';
import 'package:medicinedeliveryapp/controllers/pharmacist_products.dart';
import 'package:medicinedeliveryapp/models/product_model.dart';
import 'package:medicinedeliveryapp/pages/patient/patient_store.dart';
import 'package:medicinedeliveryapp/pages/patient/profile.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/add_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyProduct(),
    );
  }
}

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  late Future<List<ProductItem>> futureCart;
  @override
  void initState() {
    super.initState();
    futureCart = getProducts(context) as Future<List<ProductItem>>;
  }

  Future<void> deleteItem(String itemId) async {
    await deleteFromProduct(context, itemId);
    setState(() {
      futureCart = getProducts(context) as Future<List<ProductItem>>; // Re-fetch or adjust your list accordingly
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        "Product Inventory",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0), 
          child: Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()), 
                );
              },
              child: Container(
                width: 100,
                child: Row(
                  children: [Icon(Icons.add),SizedBox(width: 5,),Text('Add Product',style: TextStyle(fontSize: 12,color: Colors.white, fontWeight: FontWeight.bold),),],
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, 
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Expanded(
          child: Center(
            child: FutureBuilder<List<ProductItem>>(
              future: futureCart,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final allItems = snapshot.data!;
                  return ListView.builder(
                    itemCount: allItems.length,
                    itemBuilder: (context, index) {
                      final item = allItems[index];
                      return ExpandedCard(
                        imageUrl: item.images[0],
                        name: item.name,
                        description: item.description,
                        company: item.manufacturer,
                        expiredate: item.expiryDate.toIso8601String(),
                        onDelete: () => deleteItem(item.id),
                      );
                    },
                  );
                } else {
                  return const Text("No data available");
                }
              },
            ),
          ),
        ),
      ],
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
