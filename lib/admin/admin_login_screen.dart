import 'package:flutter/material.dart';
import 'package:village_voice/admin/admin_dashboard.dart'; // Replace `your_project_name` with your project name

class AdminLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF153448), // Background color for the screen
      appBar: AppBar(
        backgroundColor: Color(0xFF153448), // Same background color as the screen
        elevation: 0, // Remove shadow under the AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      resizeToAvoidBottomInset: true, // Automatically adjust for the keyboard
      body: SingleChildScrollView( // Make the screen scrollable
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Padding around the body
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo or image at the top (use any image or widget)
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/home_check.png', // Replace with your admin logo asset
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 30), // Space between the image and the input fields

              // Username field
              TextField(
                style: TextStyle(color: Colors.white), // Text color
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  labelStyle: TextStyle(color: Colors.white), // Label text color
                  hintStyle: TextStyle(color: Colors.white60), // Hint text color (slightly transparent white)
                  prefixIcon: Icon(Icons.person, color: Colors.white), // Icon color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between the username and password fields

              // Password field
              TextField(
                obscureText: true, // For hiding the password
                style: TextStyle(color: Colors.white), // Text color
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  labelStyle: TextStyle(color: Colors.white), // Label text color
                  hintStyle: TextStyle(color: Colors.white60), // Hint text color (slightly transparent white)
                  prefixIcon: Icon(Icons.lock, color: Colors.white), // Icon color
                  suffixIcon: Icon(Icons.visibility, color: Colors.white), // Eye icon color to show/hide password
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 40), // Space between the password field and the login button

              // Login button
              ElevatedButton(
                onPressed: () {
                  // Navigate to AdminDashboard screen when login is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminDashboard()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Color(0xFF4F6979), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
