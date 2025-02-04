import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final String hint;
  final String value;
  final ValueChanged<String?>? onChanged;
  final List<String> items;

  const CustomDropdownButton({super.key, required this.hint, required this.value, required this.onChanged, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0), // Adds margin on the sides
      child: DropdownButton<String>(
        value: value,
        dropdownColor: Colors.grey[900],
        style: TextStyle(color: Colors.white, fontSize: 18),
        hint: Text(hint),
        onChanged: onChanged,
        icon: Align(
          alignment: Alignment.centerRight,  // Move icon to the right
          child: Icon(Icons.arrow_drop_down, color: Colors.white), // Change the color as needed
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
      ),
    );
  }
}