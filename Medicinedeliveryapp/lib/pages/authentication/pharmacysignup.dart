import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPharmacyPage extends StatefulWidget {
  @override
  _RegisterPharmacyPageState createState() => _RegisterPharmacyPageState();
}

class _RegisterPharmacyPageState extends State<RegisterPharmacyPage> {
  Color customColor = Color.fromARGB(255, 25, 154, 142);
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  XFile? _imageFile;

  String _pharmacyName = "";
  String _address = "";
  String _zipCode = "";
  String _businessRegistration = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Pharmacy',
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        backgroundColor: customColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //     'Pharmacy Details',
                //     style: TextStyle(
                //       fontSize: 28.0,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // Pharmacy Name Textfield
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Pharmacy Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter pharmacy name';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    setState(() {
                      _pharmacyName = newValue!;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                // Address Textfield
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    setState(() {
                      _address = newValue!;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                // Zip Code Textfield
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Zip Code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter zip code';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    setState(() {
                      _zipCode = newValue!;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                // Business Registration Textfield
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Business Registration Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter business registration number';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    setState(() {
                      _businessRegistration = newValue!;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                // Image Picker Button
                ElevatedButton(
                  onPressed: () {
                    _getImage();
                  },
                  child: Text('Upload Pharmacy Photo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                if (_imageFile != null) SizedBox(height: 16.0),
                if (_imageFile != null)
                  // Display Selected Image
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.file(File(_imageFile!.path)),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data added!'),
                      ),
                    );
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                  },
                  child: Text('Register Pharmacy'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      }
    });
  }
}
