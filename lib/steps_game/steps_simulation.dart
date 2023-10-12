import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

import 'package:matma/board_simulation/equation_board.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/levels/tutorial.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/presentation/arrow.dart';
import 'package:matma/steps_game/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_game/items/equator/presentation/equator.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/presentation/floor.dart';
import 'package:matma/task_simulation/cubit/task_simulation_cubit.dart';
import 'package:matma/task_simulation/task.dart';
import 'package:matma/task_simulation/task_simulator.dart';

class StepsGame extends StatelessWidget {
  const StepsGame({super.key, required this.data});
  final StepsGameData data;
  @override
  Widget build(BuildContext context) {
    List<UniqueKey> blockedIds = [];
    double unitRatio = 1 / 18;
    double horizUnitRatio = 1 / 66;
    var simSize = SimulationSize(hRatio: unitRatio, wRatio: horizUnitRatio);
    final taskCubit = TaskSimulationCubit(
        data.firstTask, BlocProvider.of<LevelCubit>(context));
    final eqCubit = EquationBoardBloc(
        taskCubit: taskCubit,
        init: EquationBoardState(),
        simSize: simSize,
        initNumbers: data.initNumbers);
    final bloc = StepsGameBloc(simSize, eqCubit, taskCubit);
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<StepsGameBloc>(create: (context) => bloc),
            BlocProvider<EquationBoardBloc>(create: (context) => eqCubit),
            BlocProvider<TaskSimulationCubit>(create: (context) => taskCubit)
          ],
          child: StepsSimulatorContent(
            bloc: bloc,
            blockedIds: blockedIds,
            unitRatio: unitRatio,
            horizUnitRatio: horizUnitRatio,
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
    required this.unitRatio,
    required this.horizUnitRatio,
    required this.data,
  });
  final StepsGameData data;
  final StepsGameBloc bloc;
  final List<UniqueKey> blockedIds;
  final double unitRatio;
  final double horizUnitRatio;

  @override
  Widget build(BuildContext context) {
    return _ScrollListener(
      data: data,
      bloc: bloc,
      blockedIds: blockedIds,
      unitRatio: unitRatio,
      horizUnitRatio: horizUnitRatio,
      child: _StepsSimulatorContent(
          data: data, unitRatio: unitRatio, horizUnitRatio: horizUnitRatio),
    );
  }
}

class _ScrollListener extends StatelessWidget {
  const _ScrollListener({
    required this.bloc,
    required this.blockedIds,
    required this.unitRatio,
    required this.horizUnitRatio,
    required this.child,
    required this.data,
  });
  final StepsGameData data;
  final StepsGameBloc bloc;
  final List<UniqueKey> blockedIds;
  final double unitRatio;
  final double horizUnitRatio;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerSignal: (event) {
          var hover = hoverKepper;
          if (event is PointerScrollEvent && hover != null) {
            var item = bloc.state.getItem(hover);
            if (item != null) {
              if (bloc.state.isLastItem(item)) {
                if (!blockedIds.contains(hover)) {
                  blockedIds.add(hover);
                  bloc.add(StepsGameEventScroll(hover, 1));
                  Future.delayed(
                          const Duration(milliseconds: 800)) //garbage delay
                      .whenComplete(() => blockedIds.remove(hover));
                }
              }
            }
          }
          if (!blockedIds.contains(hoverKepper)) {
            if (event is PointerScrollEvent && hoverKepper != null) {
              bloc.add(
                  StepsGameEventScroll(hoverKepper!, event.scrollDelta.dy));
            }
          }
        },
        child: child);
  }
}

class _StepsSimulatorContent extends StatelessWidget {
  const _StepsSimulatorContent({
    super.key,
    required this.unitRatio,
    required this.horizUnitRatio,
    required this.data,
  });
  final StepsGameData data;
  final double unitRatio;
  final double horizUnitRatio;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18 * unitRatio,
      width: 66 * horizUnitRatio,
      // color: defaultBackground,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: BackButton(
                color: Colors.white,
              ),
            ),
          ),
          Opacity(
            opacity: 1.0,
            child: Container(
              color: defaultBackground,
            ),
          ),
          data.shadedSteps != null
              ? RawStepsGameExample(
                  unitRatio: unitRatio,
                  horizUnitRatio: horizUnitRatio,
                  simSize:
                      SimulationSize(hRatio: unitRatio, wRatio: horizUnitRatio),
                  initNumbers: data.shadedSteps!)
              : const SizedBox.shrink(),
          RawStepsGame(unitRatio: unitRatio, horizUnitRatio: horizUnitRatio),
          data.withEquationBoard
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: EquationBoard(unit: unitRatio),
                )
              : const SizedBox.shrink(),
          TaskSimulator(
            unit: unitRatio,
          ),
        ],
      ),
    );
  }
}

class RawStepsGameExample extends StatelessWidget {
  const RawStepsGameExample(
      //todo add shadow? maybe by merging drawpaths??? idk
      {super.key,
      required this.unitRatio,
      required this.horizUnitRatio,
      required this.simSize,
      required this.initNumbers});
  final List<int> initNumbers;
  final double unitRatio;
  final double horizUnitRatio;
  final SimulationSize simSize;

  @override
  Widget build(BuildContext context) {
    final taskCubit = TaskSimulationCubit(Task(instructions: [], onEvents: []),
        BlocProvider.of<LevelCubit>(context));

    final eqCubit = EquationBoardBloc(
        taskCubit: taskCubit,
        init: EquationBoardState(),
        simSize: simSize,
        initNumbers: initNumbers);

    final bloc = StepsGameBloc(simSize, eqCubit, taskCubit);
    return MultiBlocProvider(
      providers: [
        BlocProvider<StepsGameBloc>(create: (context) => bloc),
        BlocProvider<EquationBoardBloc>(create: (context) => eqCubit),
      ],
      child: Stack(children: [
        RawStepsGame(unitRatio: unitRatio, horizUnitRatio: horizUnitRatio),
        Opacity(
          opacity: 0.75,
          child: Container(
            color: defaultBackground,
          ),
        ),
      ]),
    );
  }
}

class RawStepsGame extends StatelessWidget {
  const RawStepsGame({
    super.key,
    required this.unitRatio,
    required this.horizUnitRatio,
  });

  final double unitRatio;
  final double horizUnitRatio;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 1 * unitRatio * MediaQuery.of(context).size.height,
        ),
        SizedBox(
          height: 17 * unitRatio * MediaQuery.of(context).size.height,
          width: 65 * horizUnitRatio * MediaQuery.of(context).size.width,
          child: BlocBuilder<StepsGameBloc, StepsGameState>(
            builder: (context, state) {
              List<SimulationItemCubit> items = [];
              for (var number in state.numbers) {
                for (var item in number.steps) {
                  items.add(item.arrow);
                  items.add(item.floor);
                }
              }
              for (var value in state.unorderedItems.values) {
                items.add(value);
              }

              return Stack(clipBehavior: Clip.hardEdge, children: [
                ...state.unorderedItems.values.map(
                  (cubit) {
                    if (cubit is EquatorCubit) {
                      return Equator(
                        cubit: cubit,
                        key: cubit.state.id,
                      );
                    } else if (cubit is FloorCubit) {
                      return Floor(cubit: cubit, key: cubit.state.id);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                ...items.map(
                  (cubit) {
                    if (cubit is FloorCubit) {
                      return Floor(cubit: cubit, key: cubit.state.id);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                ...items.map(
                  (cubit) {
                    if (cubit is ArrowCubit) {
                      return Arrow(cubit: cubit, key: cubit.state.id);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ]);
            },
          ),
        ),
      ],
    );
  }
}
