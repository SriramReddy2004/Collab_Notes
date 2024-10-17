import 'package:flutter/material.dart';

class ViewNotes extends StatelessWidget {
  final List<Map<String, dynamic>> notes;
  final String notesType; // final should be added

  const ViewNotes({Key? key, required this.notes, required this.notesType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notesType),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index]['noteId'] ?? {};
          final title = note['title'] ?? 'Untitled';

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  PersonalNotes(content:note['content'] ?? '',title: title,)
                  ),
                );
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: ListTile(
                    leading: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/4021/4021693.png",
                      width: 50,
                      height: 50,
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PersonalNotes extends StatefulWidget {
  final String content;
  final String title;
  const PersonalNotes({super.key, required this.content, required this.title});

  @override
  State<PersonalNotes> createState() => _PersonalNotesState();
}

class _PersonalNotesState extends State<PersonalNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Notes"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.sizeOf(context).height - 200,
                  width: MediaQuery.sizeOf(context).width - 30,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xffA594F9),
                    borderRadius: BorderRadius.circular(10),
 ),
                  child: Text(
                    widget.content,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                         
                        },
                        child: const Text('Delete',style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: const Color(0xffA594F9),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        child: const Text('Permissions',style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: const Color(0xffA594F9),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        child: const Text('Edit',style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor:  const Color(0xffA594F9),
                        ),
                      ),
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


