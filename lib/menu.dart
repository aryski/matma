import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/color_schemes.g.dart';
import 'package:matma/equation/items/board/presentation/board.dart';
import 'package:matma/levels/levels/level1.dart';
import 'package:matma/levels/levels/level2.dart';
import 'package:matma/levels/levels/level3.dart';
import 'package:matma/levels/levels/level4.dart';
import 'package:matma/levels/levels/level5.dart';
import 'package:matma/levels/levels/level6.dart';
import 'package:matma/levels/levels/level7.dart';
import 'package:matma/common/square_button/square_button.dart';
import 'package:matma/main.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Scaffold(
          body: Center(
              child: Column(children: [
            Align(
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
                      icon: Icon((BlocProvider.of<AppCubit>(context).state ==
                              ThemeMode.dark)
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined))),
            ),
            const Spacer(),
            const Logo(),
            const Spacer(flex: 2),
            const PickMenu(),
            const Spacer(flex: 6),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)))),
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
                                        applicationVersion: "1.0",
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
          ])),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 35 / 9,
                child: Stack(alignment: Alignment.center, children: [
                  BoardDesign(
                    fillColor: Theme.of(context).colorScheme.background,
                    frameColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
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
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class PickMenu extends StatelessWidget {
  const PickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var levels = [
      getLevel1(),
      getLevel2(),
      getLevel3(),
      getLevel4(),
      getLevel5(),
      getLevel6(),
      getLevel7()
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 3),
        ...List.generate(
            levels.length * 2,
            (index) => index % 2 == 0
                ? Expanded(
                    flex: 5,
                    child: AspectRatio(
                        aspectRatio: 1.0,
                        child: levels[index ~/ 2].generateButton()),
                  )
                : const Spacer()),
        const Spacer(flex: 2),
      ],
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
