import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicinedeliveryapp/controllers/prescriptionController.dart';
import 'package:medicinedeliveryapp/pages/patient/patient_prescription.dart';

class CaptureImagePage extends StatefulWidget {
  @override
  _CaptureImagePageState createState() => _CaptureImagePageState();
}

class _CaptureImagePageState extends State<CaptureImagePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _getImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, 
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
  Future<void> _getImageCamera() async {
  final XFile? pickedFile = await _picker.pickImage(
    source: ImageSource.camera,
  );
  setState(() {
    _imageFile = pickedFile;
  });
}


  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    final String? result = await uploadPrescription(
      context: context,
      imageFile: File(_imageFile!.path),
    );

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Prescription uploaded successfully'),
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PrescriptionPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload prescription'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null) Image.file(File(_imageFile!.path)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _getImage(),
                  icon: Icon(Icons.photo_library),
                  label: Text('Gallery'),
                ),
                SizedBox(width: 10.0),
                ElevatedButton.icon(
                  onPressed:
                      _getImageCamera,
                  icon: Icon(Icons.photo_camera_front),
                  label: Text('Camera'),
                ),
                SizedBox(width: 10.0),
              ],
            ),
                ElevatedButton.icon(
                  onPressed:
                      _uploadImage,
                  icon: Icon(Icons.cloud_upload),
                  label: Text('Upload'),
                ),
          ],
        ),
      ),
    );
  }
}
