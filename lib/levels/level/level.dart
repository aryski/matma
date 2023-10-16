import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/level_summary.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/steps_game/steps_game.dart';

/* Use                
  BlocProvider.of<LevelCubit>(context).nextGame();
  when game is finished
*/
class Level extends StatelessWidget {
  const Level({super.key, required this.data});
  final LevelData data;

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
                            const LevelSummary(),
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
