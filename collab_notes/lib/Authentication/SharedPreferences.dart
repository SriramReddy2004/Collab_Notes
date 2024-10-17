import 'package:collab_notes/Apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Function to store login status
  Future<void> storeLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  // Function to store user token
  Future<void> storeUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
  }

  // Function to retrieve user token
  Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken');
  }

  // Function to check if the user is logged out
  Future<bool> isUserLoggedout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return true; // Modify this logic as needed for your app
  }

  // Function to check if the user is logged in
  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Function to remove logged-in state and token
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }
}