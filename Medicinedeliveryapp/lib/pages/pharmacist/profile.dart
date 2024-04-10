import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/components/card_button.dart';
// import 'package:medicinedeliveryapp/pages/pharmacist/product_store.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://placeimg.com/640/480/people'),
                radius: 50.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'User Name', // Replace with username
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
