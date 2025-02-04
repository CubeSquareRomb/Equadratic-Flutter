import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSimpleEqView = true;

  @override
  void initState() {
    super.initState();
    _loadCheckboxState();
  }

  Future<void> _loadCheckboxState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSimpleEqView = prefs.getBool('simple_view') ?? true;
    });
  }

  Future<void> _saveCheckboxState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('simple_view', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CheckboxListTile(
              title: Text('Simple view of equation', style: TextStyle(color: Colors.white)),
              value: isSimpleEqView,
              onChanged: (bool? newValue) {
                setState(() {
                  isSimpleEqView = newValue!;
                });
                _saveCheckboxState(newValue!);
              },
              controlAffinity: ListTileControlAffinity.leading,
              checkColor: Colors.white, // Foreground (icon) color
              fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  return Colors.black; // Background color
                },
              ),
              side: WidgetStateBorderSide.resolveWith(
                    (Set<WidgetState> states) => BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}