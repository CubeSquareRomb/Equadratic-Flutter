import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {
  final String text = '''This game is about solving quadratic equations at speed. This is a tutorial how to solve quadratic equations

-- Step 1: Determinate equation numbers. The equation looks like 3 numbers, for example [2, -10, 12]

-- Step 2: Simplifize an equation. If first number isn’t 1, just divide each number by this number. Equation where first number equals to 1, this equation called “reduced”

-- Step 3: Find sum and product of roots. We don’t know roots yet, but we can find their sum and product easily. Sum is a second number with opposite sign. Product equals to third number

-- Step 4: Trial and error method. We know the sum and product of the roots, so we can try to find roots manually by knowing their sum and product

=== EXAMPLE ===

Our equation is:
[2, -10, 12]

-- Step 1: Determinate equation numbers. First numbers is 2, second number is -10, third is 12

-- Step 2: Simplifize an equation. First number isn’t 1, it equals to 2, so divide each number by first number:
[2, -10, 12] → [2/2, -10/2, 12/2] → [1, -5, 6]

-- Step 3: Find sum and product of roots. We have new equation:
[1, -5, 6]. Sum of roots equals to second number with opposite sign, that is, 5. Product equals to third number, that is 6. Let’s remember the sum and product of roots

-- Step 4: Trial and error method. Sum and product of roots equal to 5 and 6. After picking some numbers, the answer is 2 and 3. Because: 2+3=5 and 2*3=6. So, 2 and 3 is the roots''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}