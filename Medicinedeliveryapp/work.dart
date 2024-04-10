import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Medical Products'),
        ),
        body: ProductGrid(),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Pain Reliever',
      'description': 'Fast acting pain relief',
      'price': '\$4.99',
      'company': 'MediCorp',
      'expireDate': 'Dec 2023',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    // Add more product maps here as needed
    // Dummy data repeated for demonstration
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              products[i]['imageUrl'],
              fit: BoxFit.cover,
              height: 100,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                products[i]['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(products[i]['description']),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(products[i]['price']),
                  Text(products[i]['company']),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Expires: ${products[i]['expireDate']}'),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Explore'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
