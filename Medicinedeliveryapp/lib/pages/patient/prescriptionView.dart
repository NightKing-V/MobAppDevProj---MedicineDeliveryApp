import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/controllers/prescriptionController.dart';
import 'package:medicinedeliveryapp/pages/patient/patient_prescription.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrescriptionViewPatient(),
    );
  }
}

class PrescriptionViewPatient extends StatefulWidget {
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
  final String status;

  const PrescriptionViewPatient({
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
    this.status = 'Awaiting to pickup',
  });

  @override
  State<PrescriptionViewPatient> createState() => _PrescriptionViewPatientState();
}

class _PrescriptionViewPatientState extends State<PrescriptionViewPatient> {
void deletePrescription() async {
    try {
      await deleteFromPrescription(context, widget.id);
      // On successful deletion, replace the current route with the Prescriptions page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PrescriptionPage()),
      );
    } catch (e) {
      // If there's an error, you might want to show an error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to delete the prescription: $e'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Dismiss the dialog
              },
              child: Text('OK'),
            ),
          ],
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
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text(
              "Delivery Status:",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(width: 20),
           Text(
              widget.status,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.green),
            ),
            ],
           ),
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
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Use spaceEvenly for equal spacing
    children: [
      
      ElevatedButton.icon(
        onPressed: deletePrescription,
          // Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => PrescriptionPage()),
          //       );
        icon: Icon(Icons.delete, color: Colors.white), // X mark icon
        label: Text("Delete"),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.red, // Set the text color to white
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
