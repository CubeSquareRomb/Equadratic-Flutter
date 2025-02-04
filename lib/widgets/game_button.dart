import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GameButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0), // Adds margin on the sides
      child: SizedBox(
        width: double.infinity, // Stretches the button horizontally
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12), // Vertical padding
            decoration: BoxDecoration(
              color: Colors.black, // Background color
              border: Border.all(
                color: Colors.white, // Outline color
                width: 2.0,          // Outline width
              ),
              borderRadius: BorderRadius.circular(50), // Rounded corners
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}