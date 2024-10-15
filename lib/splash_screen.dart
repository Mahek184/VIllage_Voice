import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Import the WelcomeScreen file

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to WelcomeScreen after a delay of 3 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // Show the splash screen
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF153448), // Updated background color to #153448
      body: Stack(
        children: [
          // Adding the 3D-like shadow elements with visible borders
          Positioned(
            top: 120, // Positioned slightly higher
            left: 50,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent, // Clear background
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4E4E61).withOpacity(0.15), // Updated circle color to #4E4E61
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF4E4E61).withOpacity(0.3), // darker shadow for depth
                      offset: Offset(0, 8), // Vertical offset for 3D effect
                      blurRadius: 6, // Soften the shadow
                    ),
                    BoxShadow(
                      color: Color(0xFF4E4E61).withOpacity(0.28), // Matching the circle color
                      offset: Offset(0, -2), // Slight offset for inner glow
                      blurRadius: 2, // Smaller blur radius
                      spreadRadius: -2, // Negative spread to tighten the glow inside
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 180, // Positioned slightly higher
            right: 50,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent, // Clear background
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4E4E61).withOpacity(0.15), // Updated circle color to #4E4E61
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF4E4E61).withOpacity(0.3), // darker shadow for depth
                      offset: Offset(0, 8), // Vertical offset for 3D effect
                      blurRadius: 6, // Soften the shadow
                    ),
                    BoxShadow(
                      color: Color(0xFF4E4E61).withOpacity(0.15), // Matching the circle color
                      offset: Offset(0, -2), // Slight offset for inner glow
                      blurRadius: 2, // Smaller blur radius
                      spreadRadius: -2, // Negative spread to tighten the glow inside
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150, // Adjust the size of the image
                  height: 150,
                  child: Image.asset('assets/home_check.png'), // Ensure you add the asset here
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
