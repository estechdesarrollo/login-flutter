import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration loginInputDecoration({
    String hintText,
    String labelText,
    IconData prefixIcon,
  }){

    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueAccent
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueAccent,
          width: 2
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.blueAccent,
        fontSize: 20
      ),
      prefixIcon: Icon(prefixIcon, color: Colors.blueAccent)
    );

  }

}