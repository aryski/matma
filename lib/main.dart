import 'dart:ui';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:matma/color_schemes.g.dart';
import 'package:matma/global_cubits/responsive_cubit.dart';
import 'package:matma/global_cubits/theme_mode_cubit.dart';
import 'package:matma/menu/menu.dart';

void main() async {
  Bloc.transformer = sequential();
  await Hive.initFlutter();
  await Hive.openBox<bool>('levels');
  Hive.box<bool>('levels').put(1, true);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeModeCubit>(
          create: (context) => ThemeModeCubit(ThemeMode.light)),
      BlocProvider<ResponsiveCubit>(
          create: (context) => ResponsiveCubit(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height)),
    ],
    child: BlocBuilder<ThemeModeCubit, ThemeMode>(builder: (context, state) {
      return MaterialApp(
          scrollBehavior: const MaterialScrollBehavior().copyWith(
              scrollbars: true,
              overscroll: true,
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.trackpad
              }),
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
