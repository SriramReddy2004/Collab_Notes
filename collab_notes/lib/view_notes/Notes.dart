import 'package:collab_notes/Apis.dart';
import 'package:collab_notes/Authentication/SharedPreferences.dart';
import 'package:collab_notes/view_notes/Personal_Notes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<Map<String, dynamic>> _notes = []; // List to store the fetched notes

  // Lists for categorized notes
  List<Map<String, dynamic>> _readNotes = [];
  List<Map<String, dynamic>> _writeNotes = [];
  List<Map<String, dynamic>> _fullNotes = [];

  @override
  void initState() {
    super.initState();
    _fetchNotes(); // Call the API to fetch notes on initialization
  }

  Future<void> _fetchNotes() async {
    final AuthService authService = AuthService();
    String? token = await authService.getUserToken();

    try {
      if (token != null) {
        final List<Map<String, dynamic>> notes = await viewNote(token); // List of maps with notes

        setState(() {
          _notes = notes; // Store the notes as a list of maps
          _categorizeNotes(); // Categorize the notes based on permissions
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Notes fetched successfully!")),
        );
      } else {
        // Handle case where token is not available
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not authenticated. Please log in.")),
        );
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  // Categorize notes into three lists based on the 'permissions' key
  void _categorizeNotes() {
    // Clear the lists before categorizing to avoid duplicates
    _readNotes.clear();
    _writeNotes.clear();
    _fullNotes.clear();

    for (var note in _notes) {
      if (note['permission'] == 'read') {
        _readNotes.add(note);
      } else if (note['permission'] == 'write') {
        _writeNotes.add(note);
      } else if (note['permission'] == 'full') {
        _fullNotes.add(note);
      }
    }
  }

  // Widget to build elevated containers with responsive UI
  Widget buildElevatedContainer({
    required VoidCallback onTap,
    required String imageUrl, // URL or path to the image
    required String heading, // Heading text
    required String quote, // Quote text
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.015,
            horizontal: screenWidth * 0.04
        ),
        child: GestureDetector(
          onTap: onTap, // Handle the tap event
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(5, 5), // Shadow offset
                  blurRadius: 15, // Softness of the shadow
                  color: Colors.grey.withOpacity(0.2), // Shadow color
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding inside the container
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image on the left side
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Optional: Rounded corners for the image
                    child: Image.network(
                      imageUrl,
                      width: screenWidth * 0.25, // Responsive width for the image
                      height: screenWidth * 0.32, // Responsive height for the image
                      fit: BoxFit.cover, // Ensures the image fits within the given width/height
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05), // Responsive space between the image and text

                  // Column for the heading and quote text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Heading text
                        Text(
                          heading,
                          style: TextStyle(
                            fontSize: screenWidth * 0.045, // Responsive font size for the heading
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.02), // Responsive space between heading and quote

                        // Quote text
                        Text(
                          quote,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035, // Responsive font size for the quote
                            color: Colors.black,
                          ),
                          maxLines: 2, // Limit the quote text to 2 lines
                          overflow: TextOverflow.ellipsis, // Ellipsis if the text is too long
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA594F9).withOpacity(0.2),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListTile(
                trailing: Lottie.network("https://lottie.host/3b533110-f66d-4c70-92d6-37c2a29975f1/4jclVjzmbg.json"),
                title: const Text(
                  "My Notes",
                  style: TextStyle(color: Colors.white, fontSize: 26),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  buildElevatedContainer(
                    onTap: () {
                      // Navigate to the personal notes screen with full permission notes
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewNotes(notes: _fullNotes,notesType: "Personal Notes",), // Ensure this class exists
                        ),
                      );
                    },
                    imageUrl: 'https://i.pinimg.com/474x/02/ef/48/02ef482b3758db5f773e291d227c4965.jpg',
                    heading: 'Personal Notes',
                    quote: 'A playground of ideas - messy but full of potential!!',
                  ),
                  buildElevatedContainer(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewNotes(notes: _writeNotes,notesType: "Collab Notes",), // Ensure this class exists
                        ),
                      );
                    },
                    imageUrl: 'https://i.pinimg.com/474x/ac/b9/49/acb94984cc75cd6274fb9a3370a272be.jpg',
                    heading: 'Collaborative Notes',
                    quote: 'Like shared toys - fun to use but not to keep!!',
                  ),
                  buildElevatedContainer(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewNotes(notes: _readNotes,notesType: "Shared Notes",), // Ensure this class exists
                        ),
                      );
                    },
                    imageUrl: 'https://i.pinimg.com/564x/43/bf/de/43bfde3e9dbd560509fc61840040d7c0.jpg',
                    heading: 'Shared Notes',
                    quote: 'Cool stories - great to read, but cannot change them.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
