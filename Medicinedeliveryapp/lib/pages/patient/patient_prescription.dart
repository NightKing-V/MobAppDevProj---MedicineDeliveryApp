import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/controllers/prescriptionController.dart';
import 'package:medicinedeliveryapp/models/prescription_model.dart';
import 'package:medicinedeliveryapp/pages/patient/prescriptionView.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/prescriptionView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrescriptionPage(),
    );
  }
}

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({super.key});

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  late Future<List<Prescription>> futureCart;
  @override
  void initState() {
    super.initState();
    futureCart = getPrescriptionsByUser(context) as Future<List<Prescription>>;
  }

  // Future<void> deleteItem(String itemId) async {
  //   await deleteFromCart(context, itemId);
  //   setState(() {
  //     futureCart = getCart(context)
  //         as Future<List<Cart>>; // Re-fetch or adjust your list accordingly
  //   });
  // }
  Future<void> deleteItem(String itemId) async {
    setState(() {
      futureCart = getPrescriptionsByUser(context) as Future<
          List<Prescription>>; // Re-fetch or adjust your list accordingly
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Prescriptions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Prescription>>(
          future: futureCart,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final allItems = snapshot.data!;
              return ListView.builder(
                itemCount: allItems.length,
                itemBuilder: (context, index) {
                  // Access the current item.
                  final item = allItems[index];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        // Navigate to new page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrescriptionViewPatient(
                                    id: item.id,
                                    firstName: item.userId.firstName,
                                    lastName: item.userId.lastName,
                                    imageUrl: item.prescriptionImage,
                                    street: item.userId.address.street,
                                    state: item.userId.address.state,
                                    city: item.userId.address.city,
                                    zipCode: item.userId.address.zipCode,
                                  )), // Replace NewPage with your target page
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Image.network(item.prescriptionImage),
                          ),
                          Expanded(
                            // Expanded used to fill the available space in Row
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ID: ${item.id}",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Owner: ${item.userId.firstName} ${item.userId.lastName}",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Date: ${item.createdAt.year}/${item.createdAt.month}/${item.createdAt.day}",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     // Your icon button tap functionality
                          //     print('IconButton tapped');
                          //   },
                          //   icon: Icon(Icons.delete, color: Colors.red),
                          // ),
                        ],
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
    );
  }
}
