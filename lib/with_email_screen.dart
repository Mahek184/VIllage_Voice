import 'package:flutter/material.dart';
import 'signin_screen.dart'; // Import your SignInScreen

class WithEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF153448),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Text(
              'Sign Up with Email',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 30),

            // Email address TextField
            TextField(
              decoration: InputDecoration(
                labelText: 'E-mail address',
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.transparent,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blueGrey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Password TextField
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.transparent,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blueGrey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Confirm Password TextField
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter Password Again',
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.transparent,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blueGrey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),

            // Password Instructions
            Text(
              'Use 8 or more characters with a mix of letters,\n numbers & symbols.',
              style: TextStyle(
                color: Colors.blueGrey.shade100,
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 30),

            // 'Get started, it’s free!' Button
            ElevatedButton(
              onPressed: () {
                // Define action for sign-up
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF4F6979), // Button background color
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Get started",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // 'Do you have already an account?' Text
            Center(
              child: Text(
                "Do you have already an account?",
                style: TextStyle(color: Colors.blueGrey.shade100),
              ),
            ),
            SizedBox(height: 10),

            // 'Sign in' Button
            ElevatedButton(
              onPressed: () {
                // Navigate to SignInScreen when the button is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF4F6979), // Button background color
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Sign in",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
