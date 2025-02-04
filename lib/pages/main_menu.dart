import 'package:equadratic/pages/settings.dart';
import 'package:equadratic/pages/tutorial.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../eq_engine.dart';
import '../widgets/game_button.dart';
import 'game_settings.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late Timer _timer;

  String eq = formatEq(generateEq([2, 3], 1));

  @override
  void initState() {
    super.initState();
    _startTimer();
  }
  
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        eq = formatEq(randomEq([-10, 10], [-10, 10]));
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Column(
              children: [
                Text('Equadratic', style: TextStyle(color: Colors.white, fontSize: 40)),
                Text(eq, style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),

            Column(
              children: [
                GameButton(
                  text: "Tutorial",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tutorial()),
                    );
                  },
                ),

                SizedBox(height: 10.0),

                GameButton(
                  text: "Play",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameSettings()),
                    );
                  },
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}