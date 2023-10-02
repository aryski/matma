import 'package:flutter/material.dart';

const Color defaultYellow = Color.fromARGB(255, 255, 217, 0);
final Color defaultGreen = Color.alphaBlend(
    const Color.fromARGB(255, 32, 200, 107).withOpacity(0.9),
    defaultBackground);
final Color defaultGrey = Color.alphaBlend(
    const Color.fromARGB(255, 217, 217, 217).withOpacity(0.5),
    defaultBackground);
final Color defaultRed = Color.alphaBlend(
    const Color.fromARGB(255, 249, 56, 101).withOpacity(0.9),
    defaultBackground);

const Color defaultBackground = Color.fromARGB(255, 23, 33, 50);

int _reduceNegative(int value) {
  return value < 0 ? 0 : value;
}

Color darkenColor(Color color, int delta) {
  int red = _reduceNegative(color.red - delta);
  int blue = _reduceNegative(color.blue - delta);
  int green = _reduceNegative(color.green - delta);
  return Color.fromARGB(255, red, green, blue);
}
