import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/controllers/prescriptionController.dart';
import 'package:medicinedeliveryapp/pages/pharmacist/prescriptions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrescriptionView(),
    );
  }
}

class PrescriptionView extends StatefulWidget {
  final String title;
  final String id;
  final String imageUrl;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String firstName;
  final String lastName;
  final String contactNo;
  final String email;

  const PrescriptionView({
    super.key,
    this.title = 'Default Title', // Default parameter if none provided
    this.id = 'Default ID',
    this.imageUrl = 'https://via.placeholder.com/150',
    this.street = 'Default Street',
    this.city = 'Default City',
    this.state = 'Default State',
    this.zipCode = 'Default Zip',
    this.firstName = 'Default First Name',
    this.lastName = 'Default Last name',
    this.contactNo = 'Default Contact',
    this.email = 'Default Email',
  });

  @override
  State<PrescriptionView> createState() => _PrescriptionViewState();
}

class _PrescriptionViewState extends State<PrescriptionView> {
  Future<void> accpetPrescription(String id) async {
    try {
      await acceptPrescription(context, id);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PrescriptionsPage()),
      );
    } catch (e) {
      // Handle any errors here, e.g., show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to update prescription: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Prescription View",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Prescription Image",
              style: TextStyle(fontSize: 14),
            )),
            Image.network(widget.imageUrl,
                width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 20),
            Center(
                child: Text(
              "Delivery Details",
              style: TextStyle(fontSize: 14),
            )),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("ID: ${widget.id}", style: TextStyle(fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("Name: ${widget.firstName} ${widget.lastName}",
                  style: TextStyle(fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("Address",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("Street: ${widget.street}",
                  style: TextStyle(fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child:
                  Text("City: ${widget.city}", style: TextStyle(fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("State: ${widget.state}",
                  style: TextStyle(fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("Zip: ${widget.zipCode}",
                  style: TextStyle(fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async{
                      await accpetPrescription(widget.id);
                      print("Delivery Confirmed");
                    },
                    icon: Icon(Icons.local_shipping, color: Colors.white),
                    label: Text("Confirm"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      print("Cancel Action");
                    },
                    icon: Icon(Icons.cancel, color: Colors.white),
                    label: Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
