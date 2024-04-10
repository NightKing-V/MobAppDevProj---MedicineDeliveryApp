import 'package:flutter/material.dart';

class Prescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tap to browse or\ndrag and drop your prescription',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.upload),
              label: Text('Upload'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.green,
                // onPrimary: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {},
              child: Text('Clear'),
              style: TextButton.styleFrom(
                // primary: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
