import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';

import 'package:matma/equation/equation.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/presentation/arrow.dart';
import 'package:matma/steps_game/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_game/items/equator/presentation/equator.dart';
import 'package:matma/steps_game/items/filling/cubit/filling_cubit.dart';
import 'package:matma/steps_game/items/filling/presentation/filling.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/presentation/floor.dart';
import 'package:matma/prompts/cubit/prompts_cubit.dart';
import 'package:matma/prompts/task.dart';
import 'package:matma/prompts/task_simulator.dart';

class StepsGame extends StatelessWidget {
  const StepsGame({super.key, required this.data});
  final StepsGameData data;
  // targetValues: numbers, pass here
  @override
  Widget build(BuildContext context) {
    List<UniqueKey> blockedIds = [];
    var gs = const GameSize(hUnits: 18, wUnits: 66);
    final taskCubit =
        PromptsCubit(data.firstTask, BlocProvider.of<LevelCubit>(context));
    final eqCubit = EquationBloc(
        init: EquationState(),
        wUnits: gs.wUnits.toInt(),
        initNumbers: data.initNumbers,
        targetValues: data.withFixedEquation);
    final bloc = StepsGameBloc(eqCubit, taskCubit, data.allowedOps,
        gs.wUnits.toInt(), gs.hUnits.toInt());
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<StepsGameBloc>(create: (context) => bloc),
            BlocProvider<EquationBloc>(create: (context) => eqCubit),
            BlocProvider<PromptsCubit>(create: (context) => taskCubit)
          ],
          child: StepsSimulatorContent(
            gs: gs,
            bloc: bloc,
            blockedIds: blockedIds,
            data: data,
          ),
        ),
      ),
    );
  }
}

class StepsSimulatorContent extends StatelessWidget {
  const StepsSimulatorContent({
    super.key,
    required this.bloc,
    required this.blockedIds,
    required this.data,
    required this.gs,
  });
  final StepsGameData data;
  final StepsGameBloc bloc;
  final List<UniqueKey> blockedIds;
  final GameSize gs;

  @override
  Widget build(BuildContext context) {
    return _ScrollListener(
      data: data,
      bloc: bloc,
      blockedIds: blockedIds,
      child: _StepsSimulatorContent(
        data: data,
        gs: gs,
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
            bloc.add(StepsGameEventScroll(hoverKepper!, event.scrollDelta.dy));
          }
        },
        child: child);
  }
}

class _StepsSimulatorContent extends StatelessWidget {
  const _StepsSimulatorContent({
    required this.data,
    required this.gs,
  });
  final StepsGameData data;
  final GameSize gs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18 * gs.hUnit,
      width: 66 * gs.wUnit,
      // color: defaultBackground,
      child: Stack(
        children: [
          Opacity(
            opacity: 1.0,
            child: Container(
              color: defaultBackground,
            ),
          ),
          if (data.shadedSteps != null)
            ShadedRawStepsGame(gs: gs, initNumbers: data.shadedSteps!),
          RawStepsGame(gs: gs),
          if (data.withEquation) Equation(gs: gs),
          TaskSimulator(unit: gs.hUnit),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: BackButton(
                color: Colors.white,
              ),
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
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShadedRawStepsGame extends StatelessWidget {
  const ShadedRawStepsGame(
      {super.key, required this.gs, required this.initNumbers});
  final List<int> initNumbers;
  final GameSize gs;

  @override
  Widget build(BuildContext context) {
    final taskCubit = PromptsCubit(Task(instructions: [], onEvents: []),
        BlocProvider.of<LevelCubit>(context));

    final eqCubit = EquationBloc(
        init: EquationState(),
        initNumbers: initNumbers,
        wUnits: gs.wUnits.toInt());

    final bloc = StepsGameBloc(
        eqCubit, taskCubit, [], gs.wUnits.toInt(), gs.hUnits.toInt());
    return MultiBlocProvider(
      providers: [
        BlocProvider<StepsGameBloc>(create: (context) => bloc),
        BlocProvider<EquationBloc>(create: (context) => eqCubit),
      ],
      child: Stack(children: [
        RawStepsGame(gs: gs),
        Opacity(
          opacity: 0.75,
          child: Container(color: defaultBackground),
        ),
      ]),
    );
  }
}

class RawStepsGame extends StatelessWidget {
  const RawStepsGame({
    super.key,
    required this.gs,
  });

  final GameSize gs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 1 * gs.hUnit * MediaQuery.of(context).size.height,
        ),
        SizedBox(
          height: 17 * gs.hUnit * MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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

              return Stack(clipBehavior: Clip.hardEdge, children: [
                ...state.unorderedItems.values.map(
                  (cubit) {
                    if (cubit is EquatorCubit) {
                      return Equator(
                        gs: gs,
                        cubit: cubit,
                        key: cubit.state.id,
                      );
                    } else if (cubit is FloorCubit) {
                      return Floor(
                        cubit: cubit,
                        key: cubit.state.id,
                        gs: gs,
                      );
                    } else if (cubit is FillingCubit) {
                      return Filling(
                        cubit: cubit,
                        key: cubit.state.id,
                        gs: gs,
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
                        gs: gs,
                      ),
                    ),
                ...items.whereType<FloorCubit>().map(
                      (cubit) => Floor(
                        cubit: cubit,
                        key: cubit.state.id,
                        gs: gs,
                      ),
                    ),
                ...items.whereType<ArrowCubit>().map(
                      (cubit) => Arrow(
                        cubit: cubit,
                        gs: gs,
                        key: cubit.state.id,
                      ),
                    ),
              ]);
            },
          ),
        ),
      ],
    );
  }
}
