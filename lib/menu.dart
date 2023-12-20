import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/color_schemes.g.dart';
import 'package:matma/equation/items/board/presentation/board.dart';
import 'package:matma/global_cubits/theme_mode_cubit.dart';
import 'package:matma/levels/levels/debug.dart';
import 'package:matma/levels/levels/level1.dart';
import 'package:matma/levels/levels/level2.dart';
import 'package:matma/levels/levels/level3.dart';
import 'package:matma/levels/levels/level4.dart';
import 'package:matma/levels/levels/level5.dart';
import 'package:matma/levels/levels/level6.dart';
import 'package:matma/levels/levels/level7.dart';
import 'package:matma/common/square_button/square_button.dart';

//TODO bajzel z rozmiarówką, może jednak spoko pomysł na resize'owanie danych wewnątrz bloc'a bo takie abstrakcje tylko utrudniają wszystkow

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Scaffold(
          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: IconButton.outlined(
                            onPressed: () {
                              var cubit =
                                  BlocProvider.of<ThemeModeCubit>(context);
                              switch (cubit.state) {
                                case ThemeMode.dark:
                                  cubit.updateThemeMode(ThemeMode.light);
                                  break;
                                case ThemeMode.light:
                                  cubit.updateThemeMode(ThemeMode.dark);
                                  break;
                                default:
                              }
                            },
                            icon: Icon((BlocProvider.of<ThemeModeCubit>(context)
                                        .state ==
                                    ThemeMode.dark)
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 110, maxWidth: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Container(
                        child: const Logo(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: SizedBox(
                        height: 45,
                        child: Text(
                          "Dodawanie i odejmowanie",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 32),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                LayoutBuilder(builder: (context, constrains) {
                  if (constrains.maxWidth > 1000) {
                    return const SizedBox(
                      height: 160,
                      child: Center(child: LevelPicker()),
                    );
                  } else {
                    return const SizedBox(
                      height: 120,
                      child: Center(child: LevelPicker()),
                    );
                  }
                }),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Theme(
                                            data: ThemeData(
                                                useMaterial3: true,
                                                textTheme: Typography.dense2021,
                                                colorScheme: lightColorScheme),
                                            child: const LicensePage(
                                              applicationName: "Matma",
                                              applicationVersion: "1.1",
                                              applicationIcon: Image(
                                                  image: AssetImage(
                                                      "web/icons/Icon-maskable-192.png")),
                                              applicationLegalese:
                                                  "Copyright (c) 2023 Adam Ryski",
                                            ),
                                          )));
                            },
                            child: const Text("Licencje")),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 35 / 9,
          child: Stack(alignment: Alignment.center, children: [
            BoardDesign(
              fillColor: Theme.of(context).colorScheme.background,
              frameColor: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                'Matma',
                style: TextStyle(
                    fontSize: 135,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class LevelPicker extends StatelessWidget {
  const LevelPicker({super.key});

  @override
  Widget build(BuildContext context) {
    var levels = [
      if (!kReleaseMode) getDebugLevel(),
      if (!kReleaseMode) getDebugLevelTrivial(),
      getLevel1(),
      getLevel2(),
      getLevel3(),
      getLevel4(),
      getLevel5(),
      getLevel6(),
      getLevel7()
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: constraints.maxHeight / 8),
              ...List.generate(
                  levels.length * 2,
                  (index) => index % 2 == 0
                      ? FittedBox(
                          fit: BoxFit.contain,
                          child: levels[index ~/ 2].generateButton(),
                        )
                      : const SizedBox.shrink()),
              SizedBox(width: constraints.maxHeight / 8)
            ],
          ),
        );
      },
    );
  }
}

class Frame extends StatelessWidget {
  const Frame({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ClassicLevelButton extends StatelessWidget {
  final Widget level;
  final IconData icon;
  final String text;
  final bool locked;

  const ClassicLevelButton(
      {super.key,
      required this.level,
      required this.icon,
      required this.text,
      required this.locked});
  @override
  Widget build(BuildContext context) {
    return SquareButton(
      sideWidth: 200,
      locked: locked,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => level));
      },
      minature: Icon(icon),
      text: text,
    );
  }
}
