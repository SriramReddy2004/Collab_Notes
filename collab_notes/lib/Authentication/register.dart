import 'package:collab_notes/Apis.dart';
import 'package:collab_notes/Authentication/SharedPreferences.dart';
import 'package:collab_notes/Authentication/login.dart';
import 'package:collab_notes/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Signup Screen
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _usernamecntrl = TextEditingController();
  final _emailcntrl = TextEditingController();
  final _passwdcntrl = TextEditingController();
  final _confirmpasscntrl = TextEditingController();

  bool _isObscured = true; // To toggle password visibility for password field
  bool _isObscured2 = true; // To toggle password visibility for confirm password field

  Icon _passwordIcon = Icon(Icons.remove_red_eye, color: Colors.grey);
  Icon _confirmPasswordIcon = Icon(Icons.remove_red_eye, color: Colors.grey);

  bool _isLoading = false; // For showing the loading spinner

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
      _passwordIcon = _isObscured
          ? Icon(Icons.remove_red_eye, color: Colors.grey)
          : Icon(Icons.visibility_off, color: Colors.grey); // Change the icon
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isObscured2 = !_isObscured2;
      _confirmPasswordIcon = _isObscured2
          ? Icon(Icons.remove_red_eye, color: Colors.grey)
          : Icon(Icons.visibility_off, color: Colors.grey); // Change the icon
    });
  }

  Future<void> _register(BuildContext context) async {
    String username = _usernamecntrl.text.trim();
    String password = _passwdcntrl.text.trim();
    String email = _emailcntrl.text.trim();
    String confirmPassword = _confirmpasscntrl.text.trim();

    if (username.isEmpty || password.isEmpty || email.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required.")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match.")),
      );
      return;
    }

    // Show loading spinner
    setState(() {
      _isLoading = true;
    });

    try {
      // Call the registerUser function from Apis.dart
      final response = await registerUser(username, password, email);

      if (response != null && response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? "Registration failed")),
        );
      }
    } catch (e,stacktrace) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(e.toString())),
      );
      debugPrint('Stacktrace: $stacktrace');
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
          padding: EdgeInsets.fromLTRB(20, 30, 25, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 290,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.pinimg.com/564x/bd/a3/17/bda3177a3943ffdbcc652b3a678a0d74.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Text(
                "Signup",
                style: TextStyle(
                  color: Color(0xffA594F9),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              customTextfield(_usernamecntrl, "Username", Icon(Icons.person, color: Colors.grey), false, null),
              customTextfield(_emailcntrl, "Email", Icon(Icons.mail, color: Colors.grey), false, null),
              customTextfield(_passwdcntrl, "Password", _passwordIcon, _isObscured, _togglePasswordVisibility),
              customTextfield(_confirmpasscntrl, "Confirm Password", _confirmPasswordIcon, _isObscured2,
                  _toggleConfirmPasswordVisibility),
              const SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : customButton("Signup", () => _register(context), context),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(color: Colors.black, fontSize: 18)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: Text(
                      " Login",
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
