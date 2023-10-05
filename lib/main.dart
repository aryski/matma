import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:matma/menu/menu.dart';
import 'package:matma/steps_simulation/stairs_simulation.dart';

void main() {
  //TODO MAP
  //TODO
  Bloc.transformer = sequential();
  runApp(MaterialApp(
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    supportedLocales: const [Locale('pl', 'PL')],
    theme: ThemeData(
      useMaterial3: true,
      textTheme: Typography.dense2021,
    ),
    color: Colors.white,
    home: const Padding(
      padding: EdgeInsets.all(20.0),
      child: Scaffold(
        body: Center(child: Menu()),
      ),
    ),
  ));
}

class Tutorial extends StatelessWidget {
  const Tutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: StepsSimulation(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              40),
    );
  }
}
