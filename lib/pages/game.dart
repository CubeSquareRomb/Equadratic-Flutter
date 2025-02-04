import 'dart:async';

import 'package:equadratic/pages/end.dart';
import 'package:flutter/material.dart';
import 'package:equadratic/eq_engine.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../format_time.dart';
import '../widgets/custom_input.dart';
import '../widgets/game_button.dart';

class Game extends StatefulWidget {
  final List<int> xRange;
  final List<int> aRange;
  final int time;
  final String mode;

  const Game({super.key, required this.time, required this.xRange, required this.aRange, required this.mode});

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  late Eq eq;
  TextEditingController _minXController = TextEditingController();
  TextEditingController _maxXController = TextEditingController();
  int solved = 0;
  bool isSimpleEqView = true;

  late int remainingTime;
  late Timer _timer;

  @override
  void dispose() {
    _minXController.dispose();
    _maxXController.dispose();
    super.dispose();
  }

  void generateEq() {
    if (widget.mode != 'Growth') {
      eq = randomEq(widget.xRange, widget.aRange);
      return;
    }

    int minX = -solved ~/ 2;
    int maxX = solved ~/ 2;
    int minA = -solved ~/ 5;
    int maxA = solved ~/ 5;

    eq = randomEq([minX, maxX], [minA, maxA]);

    print(eq.roots);
  }

  void next() {
    int userMinX = int.parse(_minXController.text);
    int userMaxX = int.parse(_maxXController.text);

    _minXController.clear();
    _maxXController.clear();

    if (eq.roots[0] != userMinX || eq.roots[1] != userMaxX) {
      return;
    }

    setState(() {
      generateEq();
      solved++;
    });

  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          _setRecord();
          _timer.cancel();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EndScreen(solved: solved)),
          );
        }
      });
    });
  }

  // Future<void> _setRecord() async {
  //   double speed = solved / (widget.time / 60); // Solved equations per minute
  //
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   if (speed > (prefs.getDouble(widget.mode) ?? 0)) {
  //     await prefs.setDouble(widget.mode, speed);
  //   }

  Future<void> _setRecord() async {
    final prefs = await SharedPreferences.getInstance();

      if (solved > (prefs.getDouble("${widget.mode}|${widget.time}") ?? 0)) {
        await prefs.setInt("${widget.mode}|${widget.time}", solved);
      }
  }

  @override
  void initState() {
    super.initState();

    _loadData();

    remainingTime = widget.time;
    _startTimer();

    generateEq();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSimpleEqView = prefs.getBool('simple_view') ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
        leading: IconButton(
          icon: Icon(Icons.close), // Cross icon
          onPressed: () {
            _setRecord();
            _timer.cancel();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EndScreen(solved: solved)),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Time: ${formatTime(remainingTime)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Solved: ${solved.toString()}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Text(
                  formatEq(eq, isSimple: isSimpleEqView),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomInput(
                            controller: _minXController,
                            label: "Min root",
                          ),
                        ),
                        const SizedBox(width: 10), // Space between inputs
                        Expanded(
                          child: CustomInput(
                            controller: _maxXController,
                            label: "Max root",
                          ),
                        ),
                      ],
                    )
                )

              ],
            ),

            GameButton(
              onPressed: next,
              text: 'Check',
            ),

          ],
        ),
      ),
    );
  }
}