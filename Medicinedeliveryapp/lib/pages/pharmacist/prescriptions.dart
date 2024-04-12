import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicinedeliveryapp/controllers/prescriptionController.dart';
import 'package:medicinedeliveryapp/models/prescription_model.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/accepted_prescriptions.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/prescriptionView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrescriptionsPage(),
    );
  }
}

class PrescriptionsPage extends StatefulWidget {
  const PrescriptionsPage({super.key});

  @override
  State<PrescriptionsPage> createState() => _PrescriptionsPageState();
}

class _PrescriptionsPageState extends State<PrescriptionsPage> {
  late Future<List<Prescription>> futureCart;
  @override
  void initState() {
    super.initState();
    futureCart = getPrescriptions(context) as Future<List<Prescription>>;
  }

  Future<void> deleteItem(String itemId) async {
    setState(() {
      futureCart = getPrescriptions(context) as Future<List<Prescription>>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Available Prescriptions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AcceptedPrescriptions()));
              },
              icon: Icon(Icons.handshake, color: Colors.white),
              label: Text("Accepted Prescriptions"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<List<Prescription>>(
                future: futureCart,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final allItems = snapshot.data!
                        .where((item) => item.pickedup == "Awaiting to Pickup")
                        .toList();

                    return ListView.builder(
                      itemCount: allItems.length,
                      itemBuilder: (context, index) {
                        final item = allItems[index];

                        return Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrescriptionView(
                                          id: item.id,
                                          firstName: item.userId.firstName,
                                          lastName: item.userId.lastName,
                                          imageUrl: item.prescriptionImage,
                                          street: item.userId.address.street,
                                          state: item.userId.address.state,
                                          city: item.userId.address.city,
                                          zipCode: item.userId.address.zipCode,
                                        )),
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                IconButton(
                                  onPressed: () {
                                    print('IconButton tapped');
                                  },
                                  icon: Icon(Icons.check, color: Colors.green),
                                ),
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
          ),
        ],
      ),
    );
  }
}
