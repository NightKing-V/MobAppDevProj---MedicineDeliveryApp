import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding:
              EdgeInsets.only(left: 20.0, top: 20.0), // Adjust padding here
          child: Text(
            'Find your ideal \nmedication',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27.0),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notification_important_rounded),
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
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  height: 40.0, // Adjust height as needed
                  child: TextField(
                    maxLines: 1, // Only occupy one line
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
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
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(
                          0xFF199A8E), // Set button foreground to white
                      backgroundColor:
                          Colors.white, // Set button background to grey
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50.0), // Round corners
                      ),
                      padding: const EdgeInsets.all(
                          12.0), // Increase padding for larger icon
                    ),
                    child: const Icon(
                      Icons.medical_services_outlined,
                      size: 30.0, // Increase icon size
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle star button press
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(
                          0xFF199A8E), // Set button foreground to white
                      backgroundColor:
                          Colors.white, // Set button background to grey
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50.0), // Round corners
                      ),
                      padding: const EdgeInsets.all(
                          12.0), // Increase padding for larger icon
                    ),
                    child: const Icon(
                      Icons.chat,
                      size: 30.0, // Increase icon size
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              Row(
                // Use Row for horizontal layout
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text at top
                children: [
                  // Text section with padding
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Text(
                        'Hello user,\nhow are you feeling\nToday?',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10.0),
                  SizedBox(
                    width: 200.0,
                    height: 200.0,
                    child: Image.asset(
                      "assets/dostorimage.jpg",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Color(0xFF199A8E),
              ),
              onPressed: () {
                // Handle home button press
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.library_books_rounded,
                color: Color(0xFF199A8E),
              ),
              onPressed: () {
                // Handle search button press
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Color(0xFF199A8E),
              ),
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
