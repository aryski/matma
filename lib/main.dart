import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:matma/color_schemes.g.dart';
import 'package:matma/menu.dart';

void main() async {
  //TODO dodatkowe tabele z liczbami reprezentjące liczby tuż nad strzałkami
  //zredukowac powtarzalny kod
  //A można jeszcze dorzucic do TASK, informacje ile czasu zajęło userowi to,
  //i jeżeli dłużej to dać ifa, który decyduje też w zależności od eventu,
  //ale też w zależności od czasu do jakiego kolejnego taska trzeba przejść.
  //wykombinuje jak bardzo rozwlekać poziomy w zależności od tego jak SZYBKO ktoś rozumie.
  //Tak, aby każdy poziom się wydłużał dopóki ktoś nie będzie odpowiednio szybko kapował o co biega.

  Bloc.transformer = sequential();
  await Hive.openBox<bool>('levels');
  Hive.box<bool>('levels').put(1, true);
  runApp(BlocProvider(
    create: (context) => AppCubit(ThemeMode.light),
    child: BlocBuilder<AppCubit, ThemeMode>(builder: (context, state) {
      print("");
      print(MediaQuery.of(context).size.height * 1920 / 1080);
      print(MediaQuery.of(context).size.height);
      return MaterialApp(
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: const [Locale('pl', 'PL')],
          theme: ThemeData(
              useMaterial3: true,
              textTheme: Typography.dense2021,
              colorScheme: lightColorScheme),
          darkTheme: ThemeData(
              useMaterial3: true,
              textTheme: Typography.dense2021,
              colorScheme: darkColorScheme),
          themeMode: state,
          home: const Menu());
    }),
  ));
}

class AppCubit extends Cubit<ThemeMode> {
  AppCubit(super.initialState);

  void updateThemeMode(ThemeMode mode) {
    emit(mode);
  }
}
