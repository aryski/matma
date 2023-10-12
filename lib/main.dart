import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:matma/menu/menu.dart';

void main() {
  //zredukowac powtarzalny kod
  //w szczegolnosci presentaton layery z powtarzalnymi animatorami.
  //myślenie jakie mogą być poziomy
  //myślenie jak zbierać z nich dane xDDD - to karkołomne zadanie
  //więc najlepiej wymyśleć kilka poziomów
  //i na ich podstawie dobrać jakich będziemy używać narzędzi
  //poziomy typu od rownania do obrazka
  //czyli dojdz do równania, robiac idealnie tak zeby sie pokrywaly symbole

  //Generowanie kolejnych poziomów w zaleznosci od tego jak SZYBKO ktoś kapuje!
  //Każdy poziom będzie się wydłużał dopóki ktoś nie będzie odpowiednio szybko kapował o co biega
  //NEW EVENTS
  //NEW EVENT Dopasowanie po rysunku to porównania tabelek xD i tyle :D i to sie przyda w 1 i 3 zadaniu
  //NEW EVENT Arrows Reducted to only one direction arrows. Only one number left
  //NEW EVENT Zliczanie ile eventsow do dojscia do tabelki
  //New Event Golden Mountain or Sea pressed

  //Wydarzenia do śledzenia kroków pośrednich?
  //Np. jak się uda jakieś konkretne rodzielenie np. 4 - 7 -> 4 -4 -3 np. good split, albo po prostu dodać golden mountain created, które leci z backendu
  //Narazie brzmi spoko xD
  //A można jeszcze dorzucic do TASK, informacje ile czasu zajęło,
  //i jeżeli dłużej to dać ifa, który decyduje też w zależności od eventu,
  //ale też w zależności od czasu do jakiego kolejnego taska trzeba przejść.

  //Zadanie 1
  //Od strzałki do dopasowania do kształtu z ciemnego rysunku, liczby dodatnie
  //Od strzałki do dopasowania do kształtu z ciemnego rysunku, liczby dodatnie i ujemne
  //Od strzałki do dopasowania do kształtu z ciemnego rysunku, liczby dodatnie i ujemne i długie

  //Zadanie 2
  //Od rysunku do strzałki i pokazanie, że wynik to zawsze fragment ostatnich strzałek spod/nad linii
  //Wprowadzenie równania
  //(moze tutaj najpierw pojawi się równanie, a rysunek będzie po paru sekundach, żeby zwrócić uwagę odbiorcy na równanie)
  //Obliczenie tego samego co w a) ale z równaniem

  //Zadanie 3
  //Od strzałki do dopasowania do równania, liczby dodatnie
  //Od strzałki do dopasowania do równania, liczby dodatnie i ujemne
  //Od strzałki do dopasowania do równania, liczby dodatnie i ujemne i długie

  //Zadanie 4
  //Coś w stylu przekształcenie jednego równania w inne daną ilością ruchów?

  //Zadanie 5 Złote góry
  //jak rozbijesz 4-7 na 4-4-3 to pojawi się animacja z w ksztalcie 4-4 gdzie wystarczy dotknąć a góra się zredukuje
  //czyli nauka rozbijania na podobne liczby.

  //Zadanie 6 Morskie doły analogicznie jak 5 zadanie.

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
