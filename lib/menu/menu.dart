import 'package:flutter/material.dart';
import 'package:matma/main.dart';
import 'package:matma/menu/level_icon/level_icon.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 33, 50),
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
      'Matma.',
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
        LevelIcon(
          active: true,
          level: Tutorial(),
        ),
        SizedBox(width: 30),
        LevelIcon(
          active: false,
          level: Tutorial(),
        ),
      ],
    );
  }
}
