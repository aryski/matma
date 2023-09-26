import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation/stairs_simulation.dart';

void main() {
  Bloc.transformer = sequential();
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true, textTheme: Typography.dense2021),
    color: Colors.white,
    home: Padding(
      padding: EdgeInsets.all(20.0),
      child: Scaffold(
        body: Center(child: Elo()),
      ),
    ),
  ));
}

class Elo extends StatelessWidget {
  const Elo({super.key});

  @override
  Widget build(BuildContext context) {
    return StepsSimulation(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom -
            40);
  }
}
