import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:village_voice/dashboard.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser != null) {
        // Successful sign-in, navigate to DashboardScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        // Sign-in failed or was canceled, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google Sign-In canceled")),
        );
      }
    } catch (error) {
      // Handle errors and show a failure message
      print('Error signing in with Google: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google Sign-In failed. Please try again.")),
      );
    }
  }

  static Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    print("User Signed Out");
  }
}
