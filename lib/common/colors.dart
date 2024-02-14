import 'package:flutter/material.dart';

const Color defYellow = Color.fromARGB(255, 241, 219, 88);
const Color shadyDefYellow = Color.fromARGB(255, 184, 164, 75);
const Color defGreen = Color.fromARGB(255, 31, 183, 101);
const Color darkGreen = Color.fromARGB(255, 47, 138, 78);
const Color defRed = Color.fromARGB(255, 226, 53, 96);
const Color darkRed = Color.fromARGB(255, 156, 48, 72);

Color darkenColor(Color color, percent) {
  return Color.alphaBlend(Colors.black.withOpacity(percent), color);
}
