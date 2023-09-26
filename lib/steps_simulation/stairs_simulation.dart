import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

import 'package:matma/board_simulation/equation_board.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';

import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/arrow/presentation/arrow.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_simulation/items/floor/presentation/floor.dart';

class StepsSimulation extends StatelessWidget {
  final double width;
  final double height;

  const StepsSimulation({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    double unit = height / 18;
    double horizUnit = width / 66;
    var simSize =
        SimulationSize(hUnit: unit, wUnit: horizUnit, hUnits: 15, wUnits: 66);
    var eqCubit = EquationBoardBloc(
        init: EquationBoardState(),
        simSize: simSize,
        initNumbers: [7, -4, 1, -2]);

    var bloc = StepsSimulationBloc(simSize, eqCubit);
    return MultiBlocProvider(
      providers: [
        BlocProvider<StepsSimulationBloc>(create: (context) => bloc),
        BlocProvider<EquationBoardBloc>(create: (context) => eqCubit)
      ],
      child: SizedBox(
        width: width,
        height: height,
        child: Listener(
          onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
              if (hoverKepper != null) {
                bloc.add(StepsSimulationEventScroll(
                    hoverKepper!, event.scrollDelta.dy));
              }
            }
          },
          child: Container(
            height: 18 * unit,
            width: 66 * horizUnit,
            color: Color.fromARGB(255, 23, 33, 50),
            child: Stack(
              children: [
                SizedBox(
                  height: 18 * unit,
                  width: 66 * horizUnit,
                  child: EquationBoard(unit: unit),
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
                            for (var item in number.items) {
                              items.add(item);
                            }
                          }
                          return Stack(children: [
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
