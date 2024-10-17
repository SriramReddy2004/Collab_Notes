import 'package:collab_notes/profile.dart';
import 'package:flutter/material.dart';
import 'Addnote.dart';
import 'view_notes/Notes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  List<Widget> _pages = [Notes(), Addnotes(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffA594F9).withOpacity(0.5),
      body: _pages[_currentIndex],
      bottomNavigationBar: ClipRRect(
       // borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          backgroundColor: Color(0xffA594F9).withOpacity(0.7),
          selectedItemColor: Colors.white,
          //fixedColor: Color(0xffA594F9).withOpacity(0.5),
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
