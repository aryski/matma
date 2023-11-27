import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:matma/menu.dart';

void main() {
  //zredukowac powtarzalny kod
  //A można jeszcze dorzucic do TASK, informacje ile czasu zajęło userowi to,
  //i jeżeli dłużej to dać ifa, który decyduje też w zależności od eventu,
  //ale też w zależności od czasu do jakiego kolejnego taska trzeba przejść.
  //wykombinuje jak bardzo rozwlekać poziomy w zależności od tego jak SZYBKO ktoś rozumie.
  //Tak, aby każdy poziom się wydłużał dopóki ktoś nie będzie odpowiednio szybko kapował o co biega.

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
