import 'package:flutter/material.dart';
import 'package:matma/steps_simulation_pro/stairs_simulation_pro.dart';

void main() {
  runApp(const MaterialApp(
    color: Colors.white,
    home: Padding(
      padding: EdgeInsets.all(20.0),
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
    return StepsSimulationPro(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom -
            40);
  }
}
