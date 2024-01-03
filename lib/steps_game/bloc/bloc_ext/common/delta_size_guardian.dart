double guardDeltaSize(
    {required double currentW, required double delta, required double minW}) {
  if (currentW + delta < minW) {
    delta = minW - currentW * 1.0000000000001; //TODO
    print("DELTA1: ${minW - currentW}");
    print("DELTA2: ${minW - currentW * 1.0000000000001}");
  }
  return delta;
}
