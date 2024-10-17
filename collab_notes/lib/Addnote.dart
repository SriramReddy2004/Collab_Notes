import 'package:collab_notes/Authentication/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:collab_notes/Apis.dart'; // Import your API file

class Addnotes extends StatefulWidget {
  const Addnotes({super.key});

  @override
  State<Addnotes> createState() => _AddnotesState();
}

class _AddnotesState extends State<Addnotes> {
  final _titlecntl = TextEditingController();
  final _notecntrl = TextEditingController();
  final AuthService authService = AuthService(); // Create an instance of AuthService

  // Cancel button function that shows an AlertDialog
  void _cancel() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Discard Changes?"),
          content: Text("Are you sure you want to discard your changes?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("No", style: TextStyle(color: Color(0xffA594F9))),
            ),
            TextButton(
              onPressed: () {
                _titlecntl.clear();  // Clear the title field
                _notecntrl.clear();  // Clear the note field
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pop(context); // Go back if possible
              },
              child: Text("Yes", style: TextStyle(color: Color(0xffA594F9))),
            ),
          ],
        );
      },
    );
  }

  // Function to show confirmation dialog before saving notes
  void _showSaveConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Save Note"),
          content: Text("Do you want to save this note?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel", style: TextStyle(color: Color(0xffA594F9))),
            ),
            TextButton(
              onPressed: () {
                _addNote(); // Call the method to save the note
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Save", style: TextStyle(color: Color(0xffA594F9))),
            ),
          ],
        );
      },
    );
  }

  // Function to handle adding the note via API
  Future<void> _addNote() async {
    String title = _titlecntl.text;
    String note = _notecntrl.text;

    // Input validation
    if (title.isEmpty || note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in both fields.")),
      );
      return; 
    }

    // Retrieve the token directly using AuthService
    String? token = await authService.getUserToken();

    // Make API call to add the note
    try {
      if (token != null) {
        // Call the API to add the note
        final response = await addNote(token, title, note); // Replace with your API function

        // Handle response
        if (response['status'] == 'success') {
          // Note added successfully
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Note saved successfully!")),
          );
          _titlecntl.clear(); // Clear the title field
          _notecntrl.clear(); // Clear the note field
        } else {
          // Handle error case
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to save note: ${response['message'] ?? 'Unknown error'}")),
          );
        }
      } else {
        // Handle case where token is not available
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User not authenticated. Please log in.")),
        );

      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffA594F9).withOpacity(0.1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 0, 5),
              child: ListTile(
                title: Text(
                  "Add Notes",
                  style: TextStyle(color: Colors.white, fontSize: 26),
                ),
                trailing: Lottie.network("https://lottie.host/3b533110-f66d-4c70-92d6-37c2a29975f1/4jclVjzmbg.json"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: _titlecntl,
                decoration: InputDecoration(
                  hintText: "Add Title here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextField(
                  maxLines: null,
                  expands: true,
                  controller: _notecntrl,
                  decoration: InputDecoration(
                    hintText: "Add your note here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.all(10),
                  ),
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSaveConfirmation, // Show confirmation on press
        child: Icon(Icons.save, color: Colors.white),
        backgroundColor: Color(0xffA594F9),
      ),
    );
  }
}
