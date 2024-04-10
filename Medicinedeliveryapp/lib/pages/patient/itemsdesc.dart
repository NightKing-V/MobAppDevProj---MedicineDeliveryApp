import 'package:flutter/material.dart';

class Itemsdesc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Drugs Detail'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                    'images/drugs.jpg'), // Replace with your image path
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Description\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fringilla consequat erat ut mi. Sed lacinia feugiat massa. Pelle neque posuere lacus at augue ultricies, nec consectetur sapien fringilla. Sed vitae arcu ex. Aenean tempus congue enim in mattis. Nullam facilisis mattis aliquam quis finibus. Quisque euismod urna vel turpis sollicitudin rutrum. Sed vel turpis at magna condimentum egestas. Sed non quam libero. Integer at imperdiet urna. Donec imperdiet dui nec pharetra rutrum.\nRead more...',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Buy Now'),
              ),
            ],
          ),
        ),
      );
  }
}
