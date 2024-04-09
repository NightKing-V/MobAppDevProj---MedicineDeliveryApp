import 'dart:ui';

import 'package:flutter/material.dart';

class Product {
  final String imageUrl;
  final String name;
  final String description;
  final String company;
  final String expireDate;

  Product({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.company,
    required this.expireDate,
  });
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ListTile(
            leading: Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "http://192.168.1.3:3000/uploads/Product/image_1712677519981.jpg"),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
            title: Text("Paracetamol"),
            subtitle: Text("headache relif medicine"),
            trailing: SizedBox(
              width: 35, // Set your desired width
              height: 35, // Set your desired height
              child: ElevatedButton(
                onPressed: () {
                  // Your onPressed functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                  shape: RoundedRectangleBorder(
                    // Shape with 5px border radius
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // Explicitly set padding to zero to eliminate any default padding
                  padding: EdgeInsets.zero,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 20, // Icon color
                  ),
                ),
              ),
            ),
            tileColor: Color.fromARGB(135, 202, 202, 202),
          ),
        ),
      ],
    );
  }
}
