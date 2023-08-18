import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation/starts_simulation.dart';

void main() {
  runApp(MaterialApp(
    color: Colors.white,
    // home: Padding(
    //   padding: const EdgeInsets.all(20.0),
    //   child: ClipRect(child: GameWidget(game: AddSimulation())),
    // ),
    home: Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipRect(
          child: SizedBox(
              width: 300,
              height: 390,
              child: GameWidget(game: StairsSimulation()))),
    ),
  ));
}
