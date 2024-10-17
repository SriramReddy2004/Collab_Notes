import 'package:collab_notes/Authentication/SharedPreferences.dart';
import 'package:collab_notes/Home.dart';
import 'package:collab_notes/Authentication/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService(); // Instantiate AuthService

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await _authService.isUserLoggedIn();

    // Navigate to the appropriate screen
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA594F9).withOpacity(0.2),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Linear Progress Indicator
          LinearProgressIndicator(),
          SizedBox(height: 20), // Space between the indicator and text
          Text(
            "Checking login status...",
            style: TextStyle(fontSize: 18,color: Colors.white),

          ),
        ],
      ),
    );
  }
}
