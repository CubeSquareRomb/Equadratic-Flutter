import 'dart:math';

class Eq {
  final List<int> eq;
  final List<int> roots;

  const Eq(this.eq, this.roots);
}

// Eq by roots and A coeff
Eq generateEq(List<int> roots, int a) {
  return Eq(
      [
        a,
        (roots[0] + roots[1]) * -a, // x1+x2 = -b/a; (x1+x2) * -a = b
        roots[0]*roots[1]*a // x1*x2 = c/a; x1*x2*a = c
      ],
      
      roots
  );
}

// Random eq by X and A range
Eq randomEq(List<int> xRange, List<int> aRange) {
  var random = Random();

  int x1 = xRange[0] + random.nextInt(xRange[1] - xRange[0] + 1);
  int x2 = xRange[0] + random.nextInt(xRange[1] - xRange[0] + 1);
  int a = aRange[0] + random.nextInt(aRange[1] - aRange[0] + 1);

  if (a == 0) {
    a = 1;
  }

  // Sort roots
  if (x1 > x2) {
    int temp = x2;
    x2 = x1;
    x1 = temp;
  }

  return Eq(generateEq([x1, x2], a).eq, [x1, x2]);
}

// Random eq by mode
List<List<int>> getEqPropsByMode(String mode) {
  List<int> xRange = [1, 1];
  List<int> aRange = [1, 1];

  switch (mode) {
    case 'Easy':
      xRange = [1, 10];

    case 'Medium':
      xRange = [-10, 10];

    case 'Hard':
      xRange = [-10, 10];
      aRange = [-10, 10];

    case 'Very Hard':
      xRange = [-20, 20];
      aRange = [-20, 20];

    case 'Extreme':
      xRange = [-30, 30];
      aRange = [-20, 20];

    case 'Reduced-20':
      xRange = [1, 20];

    case 'Reduced-30':
      xRange = [1, 30];
  }

  return [xRange, aRange];
}

// Format eq
String formatEq(Eq eq, {bool isSimple = false}) {
  if (isSimple) {
    return "${eq.eq[0]}, ${eq.eq[1]}, ${eq.eq[2]}";
  }

  // The space at the string start used for correct formatting
  return ' ${eq.eq[0]}x² + ${eq.eq[1]}x + ${eq.eq[2]} = 0'
      .replaceAll('+ -', '- ')
      .replaceAll(' 1x', ' x')
      .substring(1);

}

// Test
void main() {
  var eq = randomEq([1, 10], [1, 5]);
  print('Eq coeffs: ${eq.eq}');
  print('Roots: ${eq.roots}');
}