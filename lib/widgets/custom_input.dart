import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const CustomInput({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0), // Adds margin on the sides
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
        style: TextStyle(
          color: Colors.grey[400], // Change the normal text color here
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: TextStyle(
            color: Colors.white, // Color of the label (moved hint)
          ),
        ),
      ),
    );
  }
}