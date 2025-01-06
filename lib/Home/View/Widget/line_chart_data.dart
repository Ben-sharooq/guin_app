class LineData {
  final spots = const [
    F1Spot(1.68, 55.04),
    F1Spot(168, 35.04),
    F1Spot(16.8, 65.04),
    F1Spot(180, 23.04),
    F1Spot(150, 43.04),
    F1Spot(112, 55.04),
    F1Spot(145, 23.04),
    F1Spot(111, 66.04),
    F1Spot(177, 11.04),
    F1Spot(108, 21.04),
    F1Spot(118, 34.04),
    F1Spot(128, 7.04),
    F1Spot(100, 54.04),
    F1Spot(144, 12.04),
    F1Spot(111, 70.04),
    F1Spot(118, 40.04),
    F1Spot(111, 25.04),
    F1Spot(101, 88.04),
    F1Spot(112, 54.44),
  ];
  final leftTile = {0: '0', 20: '2k', 40: '4k', 60: '6k', 80: '8k', 100: '10k'};
  final bottomTitile = {
    0:'jan',
    10:'feb',
    20:'mar',
    30:'Apl',
    40:'may',
    50:'jun',
    60:'jul',
    70:'Aug',
    80:'sep',
    90:'oct',
   100:'nov',
   110:'dec'
  };
}

class F1Spot {
  const F1Spot(double x, double y);
}
