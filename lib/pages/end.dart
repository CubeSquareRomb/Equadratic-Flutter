import 'package:flutter/material.dart';

import 'package:equadratic/pages/main_menu.dart';
import '../widgets/game_button.dart';

class EndScreen extends StatelessWidget {
  final int solved;

  EndScreen({required this.solved});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('End'),
        automaticallyImplyLeading: false,
      ),
      body: Center( // Wrap the Column with Center
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text(
              "Solved ${solved.toString()} equations",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            GameButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainMenu()),
                );
              },
              text: 'Home',
            ),
          ],
        ),
      ),
    );
  }
}