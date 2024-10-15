import 'package:flutter/material.dart';
import 'with_email_screen.dart'; // Import the Email Screen
import 'with_phone_screen.dart'; // Import the Phone Screen

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF153448), // Background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Top Image (centered)
              Image.asset(
                'assets/home_check.png', // Replace with your image path
                height: 200,
                width: 200,        // Adjust size as per requirement
              ),
              SizedBox(height: 330), // Spacing between image and buttons

              // Google Sign Up Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background color for Google button
                  foregroundColor: Colors.black, // Text color for Google button
                  minimumSize: Size(double.infinity, 50), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded edges
                  ),
                ),
                icon: Icon(Icons.g_mobiledata_outlined), // Google icon placeholder
                label: Text(
                  'Sign up with Google',
                  style: TextStyle(fontSize: 16), // Text size
                ),
                onPressed: () {
                  // Handle Google sign-up
                },
              ),
              SizedBox(height: 20), // Spacing between buttons

              // Email Sign Up Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4F6979), // Background color for Email button
                  minimumSize: Size(double.infinity, 50), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded edges
                  ),
                ),
                child: Text(
                  'Sign up with E-mail',
                  style: TextStyle(fontSize: 16, color: Colors.white), // Text size and color
                ),
                onPressed: () {
                  // Navigate to WithEmailScreen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WithEmailScreen()),
                  );
                },
              ),
              SizedBox(height: 20), // Spacing between buttons

              // Phone Number Sign Up Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4F6979), // Background color for Phone button
                  minimumSize: Size(double.infinity, 50), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded edges
                  ),
                ),
                child: Text(
                  'Sign up with Phone Number',
                  style: TextStyle(fontSize: 16, color: Colors.white), // Text size and color
                ),
                onPressed: () {
                  // Navigate to WithPhoneScreen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WithPhoneScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
