import 'package:collab_notes/Authentication/SharedPreferences.dart';
import 'package:collab_notes/Home.dart';
import 'package:collab_notes/Authentication/register.dart';
import 'package:collab_notes/constant.dart';
import 'package:flutter/material.dart';
import '../Apis.dart';

// Login Screen
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernamecntrl = TextEditingController();
  final passwdcntrl = TextEditingController();
  bool _isObscured = true; // To toggle password visibility
  Icon _icon = const Icon(Icons.remove_red_eye, color: Colors.grey); // Initial icon
  bool _isLoading = false; // Loading state to show progress indicator

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
      _icon = _isObscured
          ? const Icon(Icons.remove_red_eye, color: Colors.grey)
          : const Icon(Icons.visibility_off, color: Colors.grey); // Change the icon
    });
  }

  Future<void> _login(BuildContext context) async {
    String username = usernamecntrl.text.trim();
    String password = passwdcntrl.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both username and password")),
      );
      return;
    }

    // Show loading spinner
    setState(() {
      _isLoading = true;
    });

    try {
      // Call the login function (from Apis.dart)
      final response = await loginUser(username, password);

      if (response != null && response['status'] == 'success') {
        String token = response['data']['token'];

        await AuthService().storeUserToken(token);
        await AuthService().storeLoginStatus(true);

        String? storedToken = await AuthService().getUserToken();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Successful")),
        );

        // Navigate to Home screen after success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        // Show error message if login fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Incorrect username or password")),
        );
      }
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Failed. Please try again later.")),
      );
    } finally {

      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 290,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://i.pinimg.com/564x/61/e8/a2/61e8a2b48dc1dbfe1b760a5c9cbb6f0e.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Text(
                "Login",
                style: TextStyle(
                  color: Color(0xffA594F9),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              // Autofocus added to the username field
              customTextfield(usernamecntrl, "Username", const Icon(Icons.person, color: Colors.grey), false, null),
              const SizedBox(height: 5),
              customTextfield(passwdcntrl, "Password", _icon, _isObscured, _togglePasswordVisibility),
              const SizedBox(height: 5),
              _isLoading
                  ? const CircularProgressIndicator() // Show loading spinner
                  : customButton("Login", () {
                _login(context); // Call the login function on button press
              }, context),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  // Add password reset functionality here
                },
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(color: Color(0xffA594F9), fontSize: 16),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup()),
                      );
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(color: Color(0xffA594F9), fontSize: 18),
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
