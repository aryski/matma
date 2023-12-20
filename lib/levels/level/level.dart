import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:matma/common/level_summary/level_summary.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/menu.dart';
import 'package:matma/steps_game/steps_game.dart';

/* Use                
  BlocProvider.of<LevelCubit>(context).nextGame();
  when game is finished
*/

class Level extends StatelessWidget {
  const Level({super.key, required this.data, this.next});
  final LevelData data;
  final Widget? next;

  Widget generateButton() {
    var unlocked = Hive.box<bool>('levels').get(data.ind) ?? false;
    return StreamBuilder(
      stream: Hive.box<bool>('levels').watch(),
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.data!.key == data.ind) {
          unlocked = snapshot.data!.value;
        }
        return ClassicLevelButton(
          locked: kReleaseMode
              ? unlocked
              : data.ind == 7
                  ? true
                  : false, //  unlock all levels in debug mode
          level: this,
          icon: data.icon,
          text: data.name,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LevelCubit(data),
      child: Stack(
        children: [
          BlocBuilder<LevelCubit, LevelState>(
            buildWhen: (previous, current) {
              return current is LevelGameState;
            },
            builder: (context, state) {
              return AnimatedSwitcher(
                switchInCurve: Curves.ease,
                switchOutCurve: Curves.ease,
                duration: const Duration(milliseconds: 500),
                child: state is LevelGameState
                    ? ((state.gameData is StepsGameData)
                        ? StepsGame(
                            key: state.key,
                            data: state.gameData as StepsGameData)
                        : const SizedBox.shrink())
                    : const SizedBox.shrink(),
              );
            },
          ),
          BlocBuilder<LevelCubit, LevelState>(
            buildWhen: (previous, current) {
              return previous is LevelGameState && current is LevelGameEndState;
            },
            builder: (context, state) {
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: (state is LevelGameEndState)
                      ? Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            Center(child: LevelSummary(next: next, data: data)),
                          ],
                        )
                      : const SizedBox.shrink());
            },
          )
        ],
      ),
    );
  }
}
