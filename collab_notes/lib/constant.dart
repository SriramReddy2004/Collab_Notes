import 'package:flutter/material.dart';

//Custom Textfield
Widget customTextfield(TextEditingController con, String str, Icon icon, bool obs, Function? onTap, {bool autoFocus = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: TextField(
      obscureText: obs,
      controller: con,
      autofocus: autoFocus,
      decoration: InputDecoration(
        hintText: str,
        prefixIcon: GestureDetector(
          onTap: () => onTap?.call(),
          child: icon,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    ),
  );
}

// Custom Button
Widget customButton(String title, VoidCallback onPressed, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Container(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xffA594F9),
          minimumSize: Size(MediaQuery.of(context).size.width, 50),
        ),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    ),
  );
}

