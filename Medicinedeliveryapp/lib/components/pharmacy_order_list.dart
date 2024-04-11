import 'package:flutter/material.dart';

String formatDateTimeString(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Construct a formatted date string
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}

class ExpandedCard extends StatelessWidget {
  final String firstName;
  final String productId;
  final int cost;
  final int qty;
  final int shipping;
  final String status;
  final String createdAt;
  final Icon sicon;
  final Function onDelete;
  final Function onMove;

  ExpandedCard({
    required this.firstName,
    required this.productId,
    required this.cost,
    required this.qty,
    required this.shipping,
    required this.status,
    required this.createdAt,
    required this.sicon,
    required this.onDelete,
    required this.onMove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User:           $firstName', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Product ID: $productId', style: TextStyle(fontSize: 16)),
            Text('Cost:            LKR ${cost.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
            Text('Quantity:      $qty', style: TextStyle(fontSize: 16)),
            Text('Shipping:      LKR ${shipping.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
            Text('Status:          $status', style: TextStyle(fontSize: 16)),
            Text('Created At:   ${formatDateTimeString(createdAt)}', style: TextStyle(fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: sicon,
                  onPressed: () => onMove(), // Implement edit functionality here
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(), // Pass the onDelete function
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
