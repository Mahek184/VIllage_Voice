import 'package:flutter/material.dart';
import 'dashboard.dart'; // Import the Dashboard screen
import 'login_screen.dart'; // Import the LoginScreen

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153448), // Dark background color
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text('Sign In'), // Title next to back button
      ),
      body: SingleChildScrollView( // Add SingleChildScrollView to avoid overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Login label placed on top of the text field
              const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              // Login input field
              TextField(
                decoration: InputDecoration(
                  hintText: 'MAIL/NUMBER', // Placeholder text inside the box
                  hintStyle: const TextStyle(color: Colors.white54),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white54),
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),

              // Password label placed on top of the text field
              const Text(
                'Password',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              // Password input field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '********', // Placeholder text inside the box
                  hintStyle: const TextStyle(color: Colors.white54),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white54),
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),

              // Remember me and Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (bool? newValue) {},
                        activeColor: Colors.white, // Checkbox color
                        checkColor: const Color(0xFF153448), // Checkmark color
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Sign in button with fixed width and height
              SizedBox(
                width: double.infinity, // Full width
                height: 56.0, // Fixed height
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Dashboard when Sign in is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3C5B6F), // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // 30 radius
                    ),
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Increased space between buttons

              // Sign Up section
              Column(
                children: [
                  const Text(
                    'If you don\'t have an account yet?',
                    style: TextStyle(color: Colors.white54),
                  ),
                  const SizedBox(height: 8),

                  // Sign up button with same width and height
                  SizedBox(
                    width: double.infinity, // Full width
                    height: 56.0, // Fixed height
                    child: ElevatedButton(
                      onPressed: () {
                        // Redirect to LoginScreen when Sign Up is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3C5B6F), // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // 30 radius
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignInScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
