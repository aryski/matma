import 'package:flutter/material.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/levels/levels/level1.dart';
import 'package:matma/levels/levels/level2.dart';
import 'package:matma/levels/levels/level3.dart';
import 'package:matma/levels/levels/level4.dart';
import 'package:matma/levels/levels/level5.dart';
import 'package:matma/levels/levels/level6.dart';
import 'package:matma/levels/levels/level7.dart';
import 'package:matma/common/square_button/square_button.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: defaultBackground,
      body: Center(
          child: Column(children: [
        Spacer(),
        Logo(),
        Spacer(flex: 2),
        PickMenu(),
        Spacer(flex: 6)
      ])),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Matma',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 135),
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
      textColor: Colors.black87,
    );
  }
}
