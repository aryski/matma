class GameSize {
  final double hUnits;
  final double wUnits;

  double get hUnit => 1 / hUnits;
  double get wUnit => 1 / wUnits;

  const GameSize({required this.hUnits, required this.wUnits});
}
