import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:matma/menu/menu.dart';

void main() {
  //zredukowac powtarzalny kod
  //NEW EVENTS
  //NEW EVENT Zliczanie ile eventsow do dojscia do tabelki
  //New Event Golden Mountain or Sea pressed

  //Wydarzenia do śledzenia kroków pośrednich?
  //Np. jak się uda jakieś konkretne rodzielenie np. 4 - 7 -> 4 -4 -3 np. good split, albo po prostu dodać golden mountain created, które leci z backendu
  //Narazie brzmi spoko xD
  //A można jeszcze dorzucic do TASK, informacje ile czasu zajęło,
  //i jeżeli dłużej to dać ifa, który decyduje też w zależności od eventu,
  //ale też w zależności od czasu do jakiego kolejnego taska trzeba przejść.

  //Zadanie 4
  //Rozbijanie 2 na 1+1, rozbijanie -3 na -1,-1,-1, rozbijanie 3-3 na 1 + 1 + 1 - 1 - 1 -1

  //Zadanie 5
  //Łączenie 1 + 1 w 2, -1, -1, -1 w -3, 1+1+1 -1-1-1 w 3-3

  //Zadanie 6 Złote góry
  //jak rozbijesz 4-7 na 4-4-3 to pojawi się animacja z w ksztalcie 4-4 gdzie wystarczy dotknąć a góra się zredukuje
  //czyli nauka rozbijania na podobne liczby.

  //Zadanie 7 Morskie doły analogicznie jak 5 zadanie.

  //Najpierw skończe poziomy a potem wykombinuje jak bardzo rozwlekać poziomy w zależności od tego jak SZYBKO ktoś rozumie.
  //Tak, aby każdy poziom się wydłużał dopóki ktoś nie będzie odpowiednio szybko kapował o co biega.

  //Sposób komunikacji, te komunikaty które lecą, żeby było widać poprzednie, ale jednocześnie żeby to było spoko xD
  //TODO przydałoby się móc oprócz wiadomości polecenia dodać wiadomośc notatkę,
  //typu, że np zauwaZż dodatkowo coś oznacza coś itd xdddd, albo zawsze na koncu
  //damy takie jak ta linia w tle?

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
