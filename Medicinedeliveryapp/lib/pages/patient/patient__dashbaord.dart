import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            'Find your ideal \nmedication',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27.0),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_rounded),
            onPressed: () {},
          ),
        ],
        toolbarHeight: kToolbarHeight + 20.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  height: 40.0,
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 40.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFF199A8E),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      padding: const EdgeInsets.all(12.0),
                    ),
                    child: const Icon(
                      Icons.medical_services_outlined,
                      size: 30.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFF199A8E),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      padding: const EdgeInsets.all(12.0),
                    ),
                    child: const Icon(
                      Icons.chat,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Text(
                        'Hello user,\nhow are you feeling\nToday?',
                        style: TextStyle(
                            fontSize: 23.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  SizedBox(
                    width: 200.0,
                    height: 200.0,
                    child: Image.asset(
                      "assets/dostorimage.jpg",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Text(
                        'Products with Offers?',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 250.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  children: [
                    productCard(
                      title: 'Paracetamol',
                      imageUrl: 'assets/product1.jpg',
                      price: 5.99,
                    ),
                    productCard(
                      title: 'streptomycin',
                      imageUrl: 'assets/streptomycin.jpg',
                      price: 3.49,
                    ),
                    productCard(
                      title: 'Eylea',
                      imageUrl: 'assets/eylea.png',
                      price: 9.99,
                    ),
                    productCard(
                      title: 'Nad Injection',
                      imageUrl:
                          'assets/nad-injection-product-header-4217804413.png',
                      price: 7.99,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                Icons.library_books_rounded,
                color: Color(0xFF199A8E),
              ),
              onPressed: () {
                // Handle search button press
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Color(0xFF199A8E),
              ),
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

Widget productCard({
  required String title,
  required String imageUrl,
  required double price,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: Container(
      width: 180.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              height: 180.0,
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 10.0,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Text(
              '\$$price',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
