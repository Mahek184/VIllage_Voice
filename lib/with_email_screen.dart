import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'dashboard.dart'; // Import your Dashboard screen

class WithEmailScreen extends StatefulWidget {
  @override
  State<WithEmailScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<WithEmailScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false;

  // Enhanced Create Account method
  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      showSnackBarMessage("Please fill all the details!");
    } else if (password != cPassword) {
      showSnackBarMessage("Passwords do not match!");
    } else if (password.length < 8) {
      showSnackBarMessage("Password should be at least 8 characters long.");
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      showSnackBarMessage(
          "Password should contain at least one uppercase letter.");
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      showSnackBarMessage("Password should contain at least one number.");
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      showSnackBarMessage(
          "Password should contain at least one special character.");
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          // Show account created message
          showSnackBarMessage("Account created successfully!");
          // Redirect to Dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
        showSnackBarMessage("Error: ${ex.message}");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Snackbar message display
  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    super.dispose();
  }

  Widget customTextField({
    required TextEditingController controller,
    required String label,
    bool isObscure = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        fillColor: Colors.transparent,
        filled: true,
        suffixIcon: suffixIcon,
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
    );
  }

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
            customTextField(
              controller: emailController,
              label: 'E-mail address',
            ),
            SizedBox(height: 20),
            customTextField(
              controller: passwordController,
              label: 'Password',
              isObscure: _isObscure,
              suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            customTextField(
              controller: cPasswordController,
              label: 'Enter Password Again',
              isObscure: true,
            ),
            SizedBox(height: 10),
            Text(
              'Use 8 or more characters with a mix of letters,\n numbers & symbols.',
              style: TextStyle(
                color: Colors.blueGrey.shade100,
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : createAccount,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4F6979),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      "Get started",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Do you already have an account?",
                style: TextStyle(color: Colors.blueGrey.shade100),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4F6979),
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
