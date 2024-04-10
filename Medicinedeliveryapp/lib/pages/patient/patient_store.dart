import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/components/product_card.dart';
import 'package:medicinedeliveryapp/controllers/cartController.dart';
import 'package:medicinedeliveryapp/controllers/productsController.dart';
import 'package:medicinedeliveryapp/pages/patient/search_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductStore(),
    );
  }
}

class ProductStore extends StatefulWidget {
  const ProductStore({super.key});

  @override
  State<ProductStore> createState() => _ProductStoreState();
}

class _ProductStoreState extends State<ProductStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            'Medical Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchProduct(),
                ),
              );
            },
          ),
        ],
        toolbarHeight: kToolbarHeight + 20.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: getAllProducts(context, null),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: ProductCard(
                          imageUrl: product['images']
                              [0], // Assuming first image in 'images' list
                          title: product['name'],
                          description: product['description'],
                          price: product['price'].toDouble(),
                          onAddToCart: () {
                            // Implement your add to cart functionality here
                            print('Adding to cart');
                            addToCart(context, product['_id'], "1");
                          },
                          onBuyNow: () {
                            // Implement your buy now functionality here
                            print('Buying now');
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

void onAddToCart() {}
void onBuyNow() {}
