import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/pages/patient/prescription.dart';

class Itemsdesc extends StatelessWidget {
  final String title, desc, price, imgurl;
  const Itemsdesc(this.title, this.desc, this.price, this.imgurl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(imgurl), // Replace with your image path
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    '\n' + desc + '',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '\n' + price + ' LKR',
                    style: TextStyle(fontSize: 18.0, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ])),
            Padding(
              padding:
                  const EdgeInsets.all(10.0), // Adjust padding values as needed
              child: ElevatedButton(
                onPressed: () {},
                child:
                    Text('Add to Cart', style: TextStyle(color: Colors.green)),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(10.0), // Adjust padding values as needed
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Prescription()),
                  );
                },
                child: Text('Buy Now', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
