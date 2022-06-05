String intToTimeLeft(int value){
  int m, s;

  m = value ~/60;
  s = value - m*60;

  String minutesLeft = m.toString().length < 2 ? "0" + m.toString() : m.toString();
  String secondsLeft = s.toString().length < 2 ? "0" + s.toString() : s.toString();

  return "$minutesLeft:$secondsLeft";
}