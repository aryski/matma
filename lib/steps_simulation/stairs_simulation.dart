import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

import 'package:matma/board_simulation/equation_board.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';

import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/arrow/presentation/arrow.dart';
import 'package:matma/steps_simulation/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_simulation/items/equator/presentation/equator.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_simulation/items/floor/presentation/floor.dart';
import 'package:matma/task_simulation/cubit/task_simulation_cubit.dart';
import 'package:matma/task_simulation/task_simulator.dart';

class StepsSimulation extends StatelessWidget {
  final double width;
  final double height;

  const StepsSimulation({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    List<UniqueKey> blockedIds = [];
    double unit = height / 18;
    double horizUnit = width / 66;
    var simSize =
        SimulationSize(hUnit: unit, wUnit: horizUnit, hUnits: 15, wUnits: 66);
    var eqCubit = EquationBoardBloc(
        init: EquationBoardState(), simSize: simSize, initNumbers: [-1]);
    var taskCubit = TaskSimulationCubit();
    var bloc = StepsSimulationBloc(simSize, eqCubit, taskCubit);
    return MultiBlocProvider(
      providers: [
        BlocProvider<StepsSimulationBloc>(create: (context) => bloc),
        BlocProvider<EquationBoardBloc>(create: (context) => eqCubit),
        BlocProvider<TaskSimulationCubit>(create: (context) => taskCubit)
      ],
      child: SizedBox(
        width: width,
        height: height,
        child: Listener(
          onPointerSignal: (event) {
            var hover = hoverKepper;
            if (event is PointerScrollEvent && hover != null) {
              var item = bloc.state.getItem(hover);
              if (item != null) {
                if (bloc.state.isLastItem(item)) {
                  if (!blockedIds.contains(hover)) {
                    blockedIds.add(hover);
                    bloc.add(StepsSimulationEventScroll(hover, 1));
                    Future.delayed(
                            const Duration(milliseconds: 800)) //garbage delay
                        .whenComplete(() => blockedIds.remove(hover));
                  }
                }
              }
            }
            if (!blockedIds.contains(hoverKepper)) {
              if (event is PointerScrollEvent && hoverKepper != null) {
                bloc.add(StepsSimulationEventScroll(
                    hoverKepper!, event.scrollDelta.dy));
              }
            }
          },
          child: Container(
            height: 18 * unit,
            width: 66 * horizUnit,
            color: defaultBackground,
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
                Column(
                  children: [
                    SizedBox(
                      height: 3 * unit,
                    ),
                    SizedBox(
                      height: 15 * unit,
                      width: 65 * horizUnit,
                      child: BlocBuilder<StepsSimulationBloc,
                          StepsSimulationState>(
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
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                            ...items.map(
                              (cubit) {
                                if (cubit is FloorCubit) {
                                  return Floor(
                                      cubit: cubit, key: cubit.state.id);
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                            ...items.map(
                              (cubit) {
                                if (cubit is ArrowCubit) {
                                  return Arrow(
                                      cubit: cubit, key: cubit.state.id);
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
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 4 * unit,
                  ),
                  child: const Center(child: Tutorial()),
                ),
                SizedBox(
                  height: 18 * unit,
                  width: 66 * horizUnit,
                  child: EquationBoard(unit: unit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
