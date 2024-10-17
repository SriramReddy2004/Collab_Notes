import 'package:collab_notes/Authentication/SharedPreferences.dart';
import 'package:collab_notes/Home.dart';
import 'package:collab_notes/Authentication/login.dart';
import 'package:flutter/material.dart';


class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedOut = await _authService.isUserLoggedout();

    if (isLoggedOut) {
      // If logged out, navigate to Login Screen

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      // If not logged out, navigate to Home Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        // Cancel button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        // Confirm logout button
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await _authService.logout();
            await _checkLoginStatus();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
