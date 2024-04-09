import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find your ideal \nmedication',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27.0),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important_rounded),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
        // Add padding to the top and bottom of the AppBar
        toolbarHeight: kToolbarHeight + 20.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Add more padding between the search bar and app bar
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Convert IconButton to ElevatedButton for better appearance
                  ElevatedButton(
                    onPressed: () {
                      // Handle favorite button press
                    },
                    child: Icon(Icons.favorite),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle star button press
                    },
                    child: Icon(Icons.star),
                  ),
                ],
              ),
              // Add more widgets as needed
              // For example, you can add more Text, Image, or other widgets here
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Handle home button press
              },
            ),
            IconButton(
              icon: Icon(Icons.library_books_rounded),
              onPressed: () {
                // Handle search button press
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Handle settings button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
