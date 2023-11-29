import 'package:flutter/material.dart';

const Color defYellow = Color(0xFFFFD900);
const Color shadyDefYellow = Color.fromARGB(255, 215, 177, 0);

const Color defGreen = Color.fromARGB(255, 31, 183, 101);
const Color shadyDefGreen = Color.fromARGB(255, 21, 163, 81);
const Color darkGreen = Color.fromARGB(255, 0, 123, 41);
const Color shadyDarkGreen = Color.fromARGB(255, 0, 103, 21);

const Color defGrey = Color.fromARGB(255, 120, 125, 133);
const Color shadyDefGrey = Color.fromARGB(255, 100, 105, 113);

const Color defRed = Color.fromARGB(255, 226, 53, 96);
const Color shadyDefRed = Color.fromARGB(255, 206, 33, 76);
const Color darkRed = Color.fromARGB(255, 166, 0, 36);
const Color shadyDarkRed = Color.fromARGB(255, 146, 0, 16);

// const Color defaultEquator = Color(0xFF212D43);
// const Color shadyDefEquator = Color.fromARGB(255, 28, 40, 62);

// const Color defaultBackground = Color(0xFF172132);

Color darkenColor(Color color, percent) {
  return Color.alphaBlend(Colors.black.withOpacity(percent), color);
}
