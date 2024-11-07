import 'dart:math';

double roundNumber(double value, int places) {
  num val = pow(10.0, places);
  return ((value * val).round().toDouble() / val);
}
