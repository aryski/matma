import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/color_schemes.g.dart';
import 'package:matma/equation/items/board/presentation/board.dart';
import 'package:matma/levels/levels/debug.dart';
import 'package:matma/levels/levels/level1.dart';
import 'package:matma/levels/levels/level2.dart';
import 'package:matma/levels/levels/level3.dart';
import 'package:matma/levels/levels/level4.dart';
import 'package:matma/levels/levels/level5.dart';
import 'package:matma/levels/levels/level6.dart';
import 'package:matma/levels/levels/level7.dart';
import 'package:matma/common/square_button/square_button.dart';
import 'package:matma/main.dart';

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
                Container(
                  height: 80,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: IconButton.outlined(
                            onPressed: () {
                              var cubit = BlocProvider.of<AppCubit>(context);
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
                            icon: Icon(
                                (BlocProvider.of<AppCubit>(context).state ==
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
                    return Container(
                      height: 160,
                      child: const Center(child: LevelPicker()),
                    );
                  } else {
                    return Container(
                      height: 120,
                      child: const Center(child: LevelPicker()),
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
        // print(constraints.maxHeight);
        // print(constraints.maxWidth);
        // int levelsPerRow = levels.length;
        // while (
        //     levelsPerRow * (constraints.maxHeight / 8 + constraints.maxHeight) >
        //         constraints.maxWidth) {
        //   levelsPerRow = (levelsPerRow / 2).ceil();
        // }
        // int count = levels.length;
        // var result = [];
        // while (count > 0) {
        //   result.add([levelsPerRow]);
        // }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: constraints.maxHeight / 8),
              ...List.generate(
                  levels.length * 2,
                  (index) => index % 2 == 0
                      ? Container(
                          height: constraints.maxHeight,
                          width: constraints.maxHeight,
                          child: AspectRatio(
                              aspectRatio: 1.0,
                              child: levels[index ~/ 2].generateButton()),
                        )
                      : const SizedBox.shrink()),
              SizedBox(width: constraints.maxHeight / 8)
            ],
          ),
        );
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: constraints.maxHeight / 8),
            ...List.generate(
                levels.length * 2,
                (index) => index % 2 == 0
                    ? Container(
                        height: constraints.maxHeight,
                        width: constraints.maxHeight,
                        child: AspectRatio(
                            aspectRatio: 1.0,
                            child: levels[index ~/ 2].generateButton()),
                      )
                    : const SizedBox.shrink()),
            SizedBox(width: constraints.maxHeight / 8)
          ],
        );
        return ListView(
          scrollDirection: Axis.horizontal,
          children: [],
        );
        // return Scrollbar(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [],
        //   ),
        // );
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
  final bool unlocked;

  const ClassicLevelButton(
      {super.key,
      required this.level,
      required this.icon,
      required this.text,
      required this.unlocked});
  @override
  Widget build(BuildContext context) {
    return SquareButton(
      width: 200,
      height: 200,
      unlocked: unlocked,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => level));
      },
      minature: Icon(icon),
      text: text,
    );
  }
}
