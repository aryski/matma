import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_cubit.dart';

class ArrowGestureDetector extends StatelessWidget {
  const ArrowGestureDetector({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var stepsSimulationBloc = context.read<StepsSimulationProBloc>();
    var id = context.read<ArrowCubit>().state.id;
    return Listener(
      // onPointerDown: (event) => TODO
      //     stepsSimulationBloc.add(StepsSimulationProClick(id, DateTime.now())),
      // onPointerUp: (event) =>
      //     stepsSimulationBloc.add(StepsSimulationProClickEnd(id, DateTime.now())),
      child: MouseRegion(
        onEnter: (event) {
          hoverKepper = id;
          context.read<ArrowCubit>().hoverStart();
        },
        onExit: (event) {
          hoverKepper = null;
          context.read<ArrowCubit>().hoverEnd();
        },
        child: child,
      ),
    );
  }
}
