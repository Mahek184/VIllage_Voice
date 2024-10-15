import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF153448), // Set background color of AppBar
        elevation: 0, // Remove AppBar shadow for a flat look
        automaticallyImplyLeading: true, // Back button enabled
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Back button icon
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
        title: const Text(
          'My Notification',
          style: TextStyle(color: Colors.white), // AppBar title color
        ),
        centerTitle: true, // Center the title text
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFF153448), // Page background color to match the image
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: [
            Image.asset(
              'assets/no-data.png', // Placeholder image, change path to your asset image
              width: 360,
              height: 360,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
