import 'dart:convert';
import 'package:http/http.dart' as http;

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => "Error: $message (Status code: $statusCode)";
}

// Generic POST request function
Future<dynamic> postRequest(String apiUrl, Map<String, dynamic> body) async {
  final headers = {
    "Content-Type": "application/json",
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: jsonEncode(body),
  );

  // Check the response status
  if (response.statusCode == 200 || response.statusCode == 201) {
    //print(response.body);
    return jsonDecode(response.body); // Return the parsed JSON data
  } else {
    throw ApiException("Request failed: ${response.body}", statusCode: response.statusCode);
  }
}

// API for logging in the user
Future<Map<String, dynamic>> loginUser(String username, String password) async {
  final String apiUrl = "https://collab-notes-97o6.onrender.com/api/auth/login";

  final data = await postRequest(apiUrl, {
    "username": username,
    "password": password,
  });

  return {"status": "success", "data": data}; // Return success data
}

// API for registering the user
Future<Map<String, dynamic>> registerUser(String username, String password, String email) async {
  final String apiUrl = "https://collab-notes-97o6.onrender.com/api/auth/register";

  final data = await postRequest(apiUrl, {
    "username": username,
    "password": password,
    "email": email,
  });

  return {"status": "success", "data": data}; // Return success data
}

// API for adding notes
Future<Map<String, dynamic>> addNote(String token, String title, String content) async {
  final String apiUrl = "https://collab-notes-97o6.onrender.com/api/create-note";

  final data = await postRequest(apiUrl, {
    "title": title,
    "content": content,
    "token": token, // Passing token in the body only
  });

  return {"status": "success", "data": data}; // Return success data
}

// API for getting all notes of a user
Future<List<Map<String, dynamic>>> viewNote(String token) async {
  final String apiUrl = "https://collab-notes-97o6.onrender.com/api/get-all-notes-of-a-user";

  final response = await postRequest(apiUrl, {
    "token": token, // Passing token in the body only
  });
  return List<Map<String, dynamic>>.from(response);
}
