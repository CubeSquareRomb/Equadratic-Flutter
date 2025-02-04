String formatTime(int seconds) {
  int s = seconds % 60;
  int m = seconds ~/ 60;

  String sString;

  if (s < 10) {
    sString = '0$s';
  } else {
    sString = s.toString();
  }

  return '$m:$sString';
}