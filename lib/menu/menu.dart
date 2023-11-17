import 'package:flutter/material.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/levels/levels/level1.dart';
import 'package:matma/levels/levels/level2.dart';
import 'package:matma/levels/levels/level3.dart';
import 'package:matma/levels/levels/level4.dart';
import 'package:matma/levels/levels/level5.dart';
import 'package:matma/levels/levels/level6.dart';
import 'package:matma/levels/levels/level7.dart';
import 'package:matma/menu/level_icon/level_icon.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // LevelButton(
        //   unlocked: true,
        //   onTap: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => const Tutorial()));
        //   },
        //   minature: const Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Icon(
        //         Icons.fitness_center_outlined,
        //         size: 150,
        //       ),
        //       Text(
        //         'Tutorial',
        //         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        //       )
        //     ],
        //   ),
        // ),
        // const SizedBox(width: 30),
        LevelButton(
          unlocked: true,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Level1()));
          },
          minature: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_box_outlined,
                size: 150,
              ),
              Text(
                'Poziom 1',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const SizedBox(width: 30),
        LevelButton(
          unlocked: true,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Level2()));
          },
          minature: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.developer_board_rounded,
                size: 150,
              ),
              Text(
                'Poziom 2',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const SizedBox(width: 30),
        LevelButton(
          unlocked: true,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Level3()));
          },
          minature: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.route_rounded,
                size: 150,
              ),
              Text(
                'Poziom 3',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const SizedBox(width: 30),
        LevelButton(
          unlocked: true,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Level4()));
          },
          minature: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.call_split_rounded,
                size: 150,
              ),
              Text(
                'Poziom 4',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const SizedBox(width: 30),
        LevelButton(
          unlocked: true,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Level5()));
          },
          minature: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.join_full_rounded,
                size: 150,
              ),
              Text(
                'Poziom 5',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const SizedBox(width: 30),
        LevelButton(
          unlocked: true,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Level6()));
          },
          minature: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.reduce_capacity_rounded,
                size: 150,
              ),
              Text(
                'Poziom 6',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const SizedBox(width: 30),
        LevelButton(
          unlocked: true,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Level7()));
          },
          minature: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.area_chart_rounded,
                size: 150,
              ),
              Text(
                'Poziom 7',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}
