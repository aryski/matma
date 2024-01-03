import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:matma/levels/levels/debug.dart';
import 'package:matma/levels/levels/level1.dart';
import 'package:matma/levels/levels/level2.dart';
import 'package:matma/levels/levels/level3.dart';
import 'package:matma/levels/levels/level4.dart';
import 'package:matma/levels/levels/level5.dart';
import 'package:matma/levels/levels/level6.dart';
import 'package:matma/levels/levels/level7.dart';

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
