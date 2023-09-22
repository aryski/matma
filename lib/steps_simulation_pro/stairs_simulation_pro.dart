import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/cubit/equation_board_cubit.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:matma/board_simulation/equation_board.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation_pro/items/arrow/presentation/arrow.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_simulation_pro/items/floor/presentation/floor.dart';

class StepsSimulationPro extends StatelessWidget {
  final double width;
  final double height;

  const StepsSimulationPro(
      {super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    double unit = height / 18;
    double horizUnit = width / 66;
    var simSize =
        SimulationSize(hUnit: unit, wUnit: horizUnit, hUnits: 15, wUnits: 60);
    var eqCubit = EquationBoardBloc(
        init: EquationBoardState(),
        simSize: simSize,
        initNumbers: [7, -4, 1, -2]);

    var bloc = StepsSimulationProBloc(simSize, eqCubit);
    return MultiBlocProvider(
      providers: [
        BlocProvider<StepsSimulationProBloc>(create: (context) => bloc),
        BlocProvider<EquationBoardBloc>(create: (context) => eqCubit)
      ],
      child: SizedBox(
        width: width,
        height: height,
        child: Listener(
          onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
              if (hoverKepper != null) {
                bloc.add(StepsSimulationProEventScroll(
                    hoverKepper!, event.scrollDelta.dy));
              }
            }
          },
          child: Stack(
            children: [
              SizedBox(
                height: 18 * unit,
                width: 60 * horizUnit,
                child: EquationBoard(unit: unit),
              ),
              SizedBox(
                height: 18 * unit,
                width: 60 * horizUnit,
                child: BlocBuilder<StepsSimulationProBloc,
                    StepsSimulationProState>(
                  builder: (context, state) {
                    return Stack(children: [
                      ...state.items.map(
                        (cubit) {
                          if (cubit is FloorCubit) {
                            return Floor(cubit: cubit, key: cubit.state.id);
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      ...state.items.map(
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
          ),
        ),
      ),
    );
  }
}
