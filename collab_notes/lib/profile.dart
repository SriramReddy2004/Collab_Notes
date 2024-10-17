import 'package:collab_notes/Authentication/logout.dart';
import 'package:flutter/material.dart';

Widget CustomContainer(BuildContext context, String text, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: MediaQuery.sizeOf(context).width - 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 15)],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    ),
  );
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA594F9).withOpacity(0.2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUPlNXBp05F4Asp2BThgjxjONPyLxUgk9EIQ&s",
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Suneeta",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  Text(
                    "sunithasunitha2554@gmail.com",
                    maxLines: 2,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomContainer(context, "Edit your Name", () {}),
                    CustomContainer(context, "Edit your Email", () {}),
                    CustomContainer(context, "Edit your Password", () {}),
                    CustomContainer(context, "Guide", () {}),
                    CustomContainer(context, "Rate the App", () {}),
                    CustomContainer(context, "Logout", () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Logout(); // Trigger the Logout dialog
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}