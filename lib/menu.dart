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
                      icon: const Icon(Icons.dark_mode_outlined))),
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
    return Stack(
      alignment: Alignment.center,
      children: [
        BoardDesign(
          width: 700,
          height: 180,
          radius: 15,
          fillColor: Theme.of(context).colorScheme.background,
          frameColor: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
        Text(
          'Matma',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 135,
              color: Theme.of(context).colorScheme.onBackground),
        ),
      ],
    );
  }
}

class PickMenu extends StatelessWidget {
  const PickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ClassicLevelButton(
            icon: Icons.add_box_outlined, text: 'Poziom 1', level: Level1()),
        SizedBox(width: 30),
        _ClassicLevelButton(
            icon: Icons.developer_board_rounded,
            text: 'Poziom 2',
            level: Level2()),
        SizedBox(width: 30),
        _ClassicLevelButton(
            icon: Icons.route_rounded, text: 'Poziom 3', level: Level3()),
        SizedBox(width: 30),
        _ClassicLevelButton(
            icon: Icons.call_split_rounded, text: 'Poziom 4', level: Level4()),
        SizedBox(width: 30),
        _ClassicLevelButton(
            icon: Icons.join_full_rounded, text: 'Poziom 5', level: Level5()),
        SizedBox(width: 30),
        _ClassicLevelButton(
            icon: Icons.reduce_capacity_rounded,
            text: 'Poziom 6',
            level: Level6()),
        SizedBox(width: 30),
        _ClassicLevelButton(
            icon: Icons.area_chart_rounded, text: 'Poziom 7', level: Level7()),
      ],
    );
  }
}

class _ClassicLevelButton extends StatelessWidget {
  final Widget level;
  final IconData icon;
  final String text;

  const _ClassicLevelButton(
      {required this.level, required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return SquareButton(
      width: 200,
      height: 200,
      unlocked: true,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => level));
      },
      minature: Icon(icon),
      text: text,
    );
  }
}
