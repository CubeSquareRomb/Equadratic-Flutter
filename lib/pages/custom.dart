import 'package:flutter/material.dart';

import '../widgets/custom_input.dart';
import '../widgets/game_button.dart';
import 'game.dart';

class Custom extends StatefulWidget {
  @override
  _CustomState createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  TextEditingController _minXController = TextEditingController();
  TextEditingController _maxXController = TextEditingController();
  TextEditingController _minAController = TextEditingController();
  TextEditingController _maxAController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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

                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomInput(
                                controller: _minAController,
                                label: "Min A",
                              ),
                            ),
                            const SizedBox(width: 10), // Space between inputs
                            Expanded(
                              child: CustomInput(
                                controller: _maxAController,
                                label: "Max A",
                              ),
                            ),
                          ],
                        )
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Expanded(
                    child: CustomInput(
                      controller: _timeController,
                      label: "Time (in seconds)",
                    ),
                  ),
                )
              ],
            ),
            SizedBox(),
            GameButton(
              onPressed: () {
                try {
                  int minX = int.parse(_minXController.text);
                  int maxX = int.parse(_maxXController.text);
                  int minA = int.parse(_minAController.text);
                  int maxA = int.parse(_maxAController.text);
                  int time = int.parse(_timeController.text);

                  if (minX > maxX || minA > maxA || time <= 0) {
                    _showError("Invalid range or time value!");
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Game(
                        xRange: [minX, maxX],
                        aRange: [minA, maxA],
                        time: time,
                        mode: 'Custom'
                      ),
                    ),
                  );
                } catch (e) {
                  _showError("Enter valid numbers!");
                }

              },
              text: 'Play',
            ),
          ]
        )
      ),
    );
  }
}