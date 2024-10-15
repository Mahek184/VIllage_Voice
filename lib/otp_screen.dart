import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF153448), // Dark background color
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, // Full screen height
          width: MediaQuery.of(context).size.width,   // Full screen width
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align items at the top
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 150), // Add a little space from the top (optional)

              // Title
              Text(
                'Enter your code',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 30),

              // OTP Input Field
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter here',
                  labelStyle: TextStyle(color: Colors.white),
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
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Text about OTP being sent
              Text(
                'We sent a 6-digit code to +192487562823',
                style: TextStyle(
                  color: Colors.blueGrey.shade100,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              // 'Verify OTP' Button
              ElevatedButton(
                onPressed: () {
                  // Define OTP verification logic here
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF4F6979), // Button background color
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "VERIFY OTP",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),

              // 'Resend Code' Section with Icon
              TextButton.icon(
                onPressed: () {
                  // Define resend code action here
                },
                icon: Icon(Icons.message_outlined, color: Colors.white),
                label: Text(
                  'Resend code',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
