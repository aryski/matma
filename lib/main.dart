import 'dart:html';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation/starts_simulation.dart';
import 'package:matma/stairs_simulation_native/stairs_simulation_native.dart';

void main() {
  runApp(MaterialApp(
    color: Colors.white,
    home: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Elo(),
    ),
    // home: Padding(
    //   padding: const EdgeInsets.all(20.0),
    //   child: ClipRect(
    //     child: GameWidget(
    //       game: StairsSimulation(),
    //     ),
    //   ),
    // ),
  ));
}

class Elo extends StatelessWidget {
  const Elo({super.key});

  @override
  Widget build(BuildContext context) {
    return StepsSimulationNative(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom -
            40);
  }
}
