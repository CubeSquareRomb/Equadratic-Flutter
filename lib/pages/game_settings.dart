import 'package:equadratic/eq_engine.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_dropdown_button.dart';
import '../widgets/game_button.dart';
import 'custom.dart';
import 'game.dart';

class GameSettings extends StatefulWidget {
  const GameSettings({super.key});

  @override
  _GameSettingsState createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  final List<String> modes = ['Easy', 'Medium', 'Hard', 'Very Hard', 'Extreme', 'Reduced-20', 'Reduced-30', 'Growth'];
  final List<String> times = ['30s', '1m', '2m', '5m', '10m'];

  String mode = "Easy";
  String stringTime = "2m";
  int highscore = -1;

  Future<void> _getHighscore() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      highscore = prefs.getInt('$mode|${timeToSeconds(stringTime)}') ?? 0;
    });
  }

  int timeToSeconds(String time) {
    switch (time) {
      case '30s': return 30;
      case '1m': return 60;
      case '2m': return 120;
      case '5m': return 300;
      case '10m': return 600;
      default: return 0;
    }
  }

  String getDiffDescr() {
    switch (mode) {
      case 'Easy': return 'Reduced equations with positive roots\nx: [1, 10]';
      case 'Medium': return 'Reduced equations\nx: [-10, 10]';
      case 'Hard': return 'Non-reduced equations\nx: [-10, 10] | a: [-10, 10]';
      case 'Very Hard': return 'Big equations\nx: [-20, 20] | a: [-20, 20]';
      case 'Extreme': return 'Huge equations\nx: [-30, 30] | a: [-30, 30]';
      case 'Reduced-20': return 'Reduced equations with positive but big roots\nx: [1, 20]';
      case 'Reduced-30': return 'Reduced equations with positive but huge roots\nx: [1, 30]';
      case 'Growth': return 'From easier to harder equations';
      default: return '<No Description>';
    }
  }

  @override
  void initState() {
    super.initState();
    _getHighscore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Highscore:\n$highscore equations',
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropdownButton(
                  hint: "Select a mode",
                  value: mode,
                  onChanged: (String? newValue) {
                    setState(() {
                      mode = newValue!;
                      _getHighscore();
                    });
                  },
                  items: modes,
                ),

                CustomDropdownButton(
                  hint: "Select a time",
                  value: stringTime,
                  onChanged: (String? newValue) {
                    setState(() {
                      stringTime = newValue!;
                      _getHighscore();
                    });
                  },
                  items: times,
                ),

                Text(getDiffDescr(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 16))
              ],
            ),

            Column(
              children: [
                GameButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Custom(),
                      ),
                    );
                  },
                  text: 'Custom',
                ),

                SizedBox(height: 10.0),

                GameButton(
                  onPressed: () {
                    List<List<int>> eqProps = getEqPropsByMode(mode);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Game(xRange: eqProps[0], aRange: eqProps[1], time: timeToSeconds(stringTime), mode: mode),
                      ),
                    );
                  },
                  text: 'Play',
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}