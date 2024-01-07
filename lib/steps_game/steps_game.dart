import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';

import 'package:matma/equation/equation.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';
import 'package:matma/quest/quests.dart';
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

class StepsGame extends StatelessWidget {
  const StepsGame({super.key, required this.data});
  final StepsGameData data;
  @override
  Widget build(BuildContext context) {
    List<UniqueKey> blockedIds = [];
    final promptCubit =
        QuestsBloc(BlocProvider.of<LevelCubit>(context), data.firstTask);
    final eqCubit = EquationBloc(
        init: EquationState(),
        wUnits: 66,
        initNumbers: data.initNumbers,
        targetValues: data.withFixedEquation);
    final bloc = StepsGameBloc(eqCubit, promptCubit, data.allowedOps);
    return DefaultTextStyle(
      style: const TextStyle(),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<StepsGameBloc>(create: (context) => bloc),
            BlocProvider<EquationBloc>(create: (context) => eqCubit),
            BlocProvider<QuestsBloc>(create: (context) => promptCubit)
          ],
          child: _ScrollListener(
            data: data,
            bloc: bloc,
            blockedIds: blockedIds,
            child: _StepsSimulatorContent(
              data: data,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScrollListener extends StatelessWidget {
  const _ScrollListener({
    required this.bloc,
    required this.blockedIds,
    required this.child,
    required this.data,
  });
  final StepsGameData data;
  final StepsGameBloc bloc;
  final List<UniqueKey> blockedIds;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent && hoverKepper != null) {
            bloc.add(
                StepsTrigEventScrollFloor(hoverKepper!, event.scrollDelta.dy));
          }
        },
        child: child);
  }
}

class _StepsSimulatorContent extends StatelessWidget {
  const _StepsSimulatorContent({
    required this.data,
  });
  final StepsGameData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 1.0,
          child: Container(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        if (data.shadedSteps != null)
          ShadedRawStepsGame(initNumbers: data.shadedSteps!),
        const Quests(),
        const RawStepsGame(),
        if (data.withEquation) const Equation(),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: BackButton(),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () {
                BlocProvider.of<LevelCubit>(context).refreshGame();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ShadedRawStepsGame extends StatelessWidget {
  const ShadedRawStepsGame({super.key, required this.initNumbers});
  final List<int> initNumbers;

  @override
  Widget build(BuildContext context) {
    final promptCubit = QuestsBloc(BlocProvider.of<LevelCubit>(context),
        MiniQuest(prompts: [], choices: []));

    final eqCubit = EquationBloc(
        init: EquationState(), initNumbers: initNumbers, wUnits: 66);

    final bloc = StepsGameBloc(eqCubit, promptCubit, []);
    return MultiBlocProvider(
      providers: [
        BlocProvider<StepsGameBloc>(create: (context) => bloc),
        BlocProvider<EquationBloc>(create: (context) => eqCubit),
      ],
      child: Stack(children: [
        const RawStepsGame(),
        Opacity(
          opacity: 0.75,
          child: Container(color: Theme.of(context).colorScheme.background),
        ),
      ]),
    );
  }
}

class RawStepsGame extends StatelessWidget {
  const RawStepsGame({super.key});

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
                    } else if (cubit is FillingCubit) {
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
                ...items.whereType<FillingCubit>().map(
                      (cubit) => Filling(
                        cubit: cubit,
                        key: cubit.state.id,
                      ),
                    ),
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
