import 'package:flutter/material.dart';
import 'package:village_voice/login_screen.dart' as login; // Alias for the login screen
import 'package:village_voice/signin_screen.dart' as signin; // Alias for the signin screen
import 'package:village_voice/admin/admin_login_screen.dart'; // Import for Admin Login Screen

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF153448), // Background color for the splash screen
      body: Stack(
        children: [
          // First circular bubble with shadow and correct color
          Positioned(
            top: 100,
            left: 50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF3C5B6F).withOpacity(0.5), // Circle color with some transparency
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Soft shadow effect
                    blurRadius: 10,
                    offset: Offset(5, 5), // Shadow positioning
                  ),
                ],
              ),
            ),
          ),
          // Second circular bubble with shadow and correct color
          Positioned(
            top: 240,
            right: 100,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF3C5B6F).withOpacity(0.5), // Circle color with some transparency
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Soft shadow effect
                    blurRadius: 10,
                    offset: Offset(5, 5), // Shadow positioning
                  ),
                ],
              ),
            ),
          ),
          // Large bubble near the image (bottom-right corner) with shadow and correct color
          Positioned(
            bottom: 270,
            right: 40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xFF3C5B6F).withOpacity(0.5), // Circle color with some transparency
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Soft shadow effect
                    blurRadius: 10,
                    offset: Offset(5, 5), // Shadow positioning
                  ),
                ],
              ),
            ),
          ),
          // Complaints box image placeholder (centered)
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.asset(
                'assets/complaint_box1.png', // Replace with your complaints box image
                fit: BoxFit.contain,
              ),
            ),
          ),
          // 'Get Started' Button
          Positioned(
            bottom: 100,
            left: 50,
            right: 50,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to LoginScreen when 'Get Started' is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => login.LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color(0xFF3C5B6F), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          // 'I have an account' Button
          Positioned(
            bottom: 40,
            left: 50,
            right: 50,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to SignInScreen when 'I have an account' is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => signin.SignInScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color(0xFF3C5B6F), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'I have an account',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          // Admin Square Box at the bottom-right corner
          Positioned(
            bottom: 12,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Navigate to AdminLoginScreen when the admin icon is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLoginScreen()),
                );
              },
              child: Stack(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFF3C5B6F), // Box color
                      borderRadius: BorderRadius.circular(8), // Square box with slightly rounded corners
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 2,
                    child: Icon(
                      Icons.admin_panel_settings, // Small admin icon
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
