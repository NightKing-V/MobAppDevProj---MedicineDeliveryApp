import 'dart:ui';

import 'package:flutter/material.dart';

String formatDateString(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);

  String formattedDate =
      "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

  return formattedDate;
}

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

class ExpandedCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final String company;
  final String expiredate;
  final VoidCallback onDelete;

  ExpandedCard({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.company,
    required this.expiredate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(imageUrl),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Text(description),
                  Text(company),
                  Text(formatDateString(expiredate)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: onDelete,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
