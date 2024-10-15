import 'package:flutter/material.dart';
import 'add_complaint_screen.dart'; // Import the AddComplaintScreen here

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EduRuleScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EduRuleScreen extends StatelessWidget {
  final Color bgColor = Color(0xFF153448); // Background color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align items at the top
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Education box with image upload
            Container(
              width: 160, // Set width to 160
              height: 160, // Set height to 160
              decoration: BoxDecoration(
                color: Color(0xFF3C5B6F), // Updated box background color
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                children: [
                  // Image widget to replace the icon, you can set an image here
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/education.png', // Replace with the path to your image
                      height: 80, // Adjusted image size to fit the new box size
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Education',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40), // Space between the education box and rules box

            // Rules To Follow section
            Text(
              'Rules To Follow',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 10),

            // Rules container
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ruleText('1. Be specific and detailed'),
                  ruleText('2. Use respectful language'),
                  ruleText('3. Provide evidence or examples'),
                  ruleText('4. Avoid submitting duplicate complaints'),
                ],
              ),
            ),
          ],
        ),
      ),
      // Floating action button positioned to the right
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            // Navigate to AddComplaintScreen on plus button press
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddComplaintScreen()),
            );
          },
          backgroundColor: Color(0xFF3C5B6F), // Matching button color with box
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  // Method to style the rules text
  Widget ruleText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
