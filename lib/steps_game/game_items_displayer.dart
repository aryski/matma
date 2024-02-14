import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';

import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/presentation/arrow.dart';
import 'package:matma/steps_game/items/brackets/cubit/bracket_cubit.dart';
import 'package:matma/steps_game/items/brackets/presentation/bracket.dart';
import 'package:matma/steps_game/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_game/items/equator/presentation/equator.dart';
import 'package:matma/steps_game/items/filling/cubit/filling_cubit.dart';
import 'package:matma/steps_game/items/filling/presentation/filling.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/presentation/floor.dart';
import 'package:matma/quest/items/mini_quest.dart';

class ShadedGameItemsDisplayer extends StatelessWidget {
  const ShadedGameItemsDisplayer({super.key, required this.initNumbers});
  final List<int> initNumbers;

  @override
  Widget build(BuildContext context) {
    final promptCubit = QuestsBloc(BlocProvider.of<LevelCubit>(context),
        MiniQuest(prompts: [], choices: []));

    final eqCubit =
        EquationBloc(init: EquationState(), initNumbers: initNumbers);

    final bloc = StepsGameBloc(eqCubit, promptCubit, []);
    return MultiBlocProvider(
      providers: [
        BlocProvider<StepsGameBloc>(create: (context) => bloc),
        BlocProvider<EquationBloc>(create: (context) => eqCubit),
      ],
      child: Stack(children: [
        const GameItemsDisplayer(),
        Opacity(
          opacity: 0.75,
          child: Container(color: Theme.of(context).colorScheme.background),
        ),
      ]),
    );
  }
}

class GameItemsDisplayer extends StatelessWidget {
  const GameItemsDisplayer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1080,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        alignment: Alignment.centerLeft,
        child: BlocBuilder<StepsGameBloc, StepsGameState>(
          builder: (context, state) {
            List<GameItemCubit> items = [];
            for (var number in state.numbers) {
              if (number.filling != null) {
                items.add(number.filling!);
              }
              for (var item in number.steps) {
                items.add(item.arrow);
                items.add(item.floor);
              }
            }
            for (var value in state.unorderedItems.values) {
              if (value is! FillingCubit) {
                items.add(value);
              }
            }

            return SizedBox(
              width: 5000,
              height: 1080,
              child: Stack(clipBehavior: Clip.hardEdge, children: [
                ...state.unorderedItems.values.map(
                  (cubit) {
                    if (cubit is EquatorCubit) {
                      return Equator(
                        cubit: cubit,
                        key: cubit.state.id,
                      );
                    } else if (cubit is FloorCubit) {
                      return Floor(
                        cubit: cubit,
                        key: cubit.state.id,
                      );
                    } else if (cubit is FillingCubit && state.showFilling) {
                      return Filling(
                        cubit: cubit,
                        key: cubit.state.id,
                      );
                    } else if (cubit is BracketCubit) {
                      return Bracket(
                        cubit: cubit,
                        key: cubit.state.id,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                ...items.whereType<FillingCubit>().map((cubit) {
                  return state.showFilling
                      ? Filling(
                          cubit: cubit,
                          key: cubit.state.id,
                        )
                      : const SizedBox.shrink();
                }),
                ...items.whereType<FloorCubit>().map(
                      (cubit) => Floor(
                        cubit: cubit,
                        key: cubit.state.id,
                      ),
                    ),
                ...items.whereType<ArrowCubit>().map(
                      (cubit) => Arrow(
                        cubit: cubit,
                        key: cubit.state.id,
                      ),
                    ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
