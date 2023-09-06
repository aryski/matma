import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
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
    var bloc = StepsSimulationProBloc([7, -4, 1, -3], unit, horizUnit, 15, 60);
    return BlocProvider(
      create: (context) => bloc,
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
          child: Column(
            children: [
              SizedBox(
                height: 3 * unit,
                child: BlocBuilder<StepsSimulationProBloc,
                    StepsSimulationProState>(
                  builder: (context, state) {
                    return Text(state.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 2 * unit,
                            fontWeight: FontWeight.bold,
                            color: Colors.black));
                  },
                ),
              ),
              SizedBox(
                height: 15 * unit,
                width: 60 * horizUnit,
                child: BlocBuilder<StepsSimulationProBloc,
                    StepsSimulationProState>(
                  builder: (context, state) {
                    return Stack(children: [
                      ...state.items.map(
                        (cubit) {
                          if (cubit is FloorCubit) {
                            return Floor(cubit: cubit);
                          } else if (cubit is ArrowCubit) {
                            return Arrow(cubit: cubit);
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
