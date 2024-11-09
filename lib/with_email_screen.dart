import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'dashboard.dart';

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

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || cPassword.isEmpty) {
      showSnackBarMessage("Please fill all the details!", Colors.red);
    } else if (password != cPassword) {
      showSnackBarMessage("Passwords do not match!", Colors.red);
      FocusScope.of(context)
          .requestFocus(FocusNode()); // Focus on password field if needed
    } else if (password.length < 8) {
      showSnackBarMessage(
          "Password should be at least 8 characters long.", Colors.red);
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      showSnackBarMessage(
          "Password should contain at least one uppercase letter.", Colors.red);
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      showSnackBarMessage(
          "Password should contain at least one number.", Colors.red);
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      showSnackBarMessage(
          "Password should contain at least one special character.",
          Colors.red);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          showSnackBarMessage("Account created successfully!", Colors.green);
          emailController.clear();
          passwordController.clear();
          cPasswordController.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
        switch (ex.code) {
          case 'email-already-in-use':
            showSnackBarMessage(
                "This email address is already in use.", Colors.red);
            break;
          case 'invalid-email':
            showSnackBarMessage("The email address is not valid.", Colors.red);
            break;
          case 'weak-password':
            showSnackBarMessage("The password is too weak.", Colors.red);
            break;
          default:
            showSnackBarMessage("Error: ${ex.message}", Colors.red);
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void showSnackBarMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
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
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.blueGrey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
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
            // Title
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 30),

            // Email Text Field
            customTextField(
              controller: emailController,
              label: 'E-mail address',
            ),
            SizedBox(height: 20),

            // Password Text Field
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

            // Confirm Password Text Field
            customTextField(
              controller: cPasswordController,
              label: 'Confirm Password',
              isObscure: true,
            ),
            SizedBox(height: 10),

            // Password Tips Text
            Text(
              'Use 8 or more characters with a mix of letters,\n numbers & symbols.',
              style: TextStyle(
                color: Colors.blueGrey.shade100,
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 30),

            // Sign Up Button
            ElevatedButton(
              onPressed: _isLoading ? null : createAccount,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4F6979),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      "Get Started",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
            ),
            SizedBox(height: 20),

            // Have an account? Text Button
            Center(
              child: Text(
                "Already have an account?",
                style: TextStyle(color: Colors.blueGrey.shade100, fontSize: 14),
              ),
            ),
            SizedBox(height: 10),

            // Sign In Text Button
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  "Sign in",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
