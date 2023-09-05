import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/stairs_simulation_native/bloc/stairs_simulation_bloc.dart';
import 'package:matma/stairs_simulation_native/items/arrow/cubit/arrow_cubit.dart';

class ArrowGestureDetector extends StatelessWidget {
  const ArrowGestureDetector({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var stepsSimulationBloc = context.read<StepsSimulationBloc>();
    var id = context.read<ArrowCubit>().state.id;
    return Listener(
      onPointerDown: (event) =>
          stepsSimulationBloc.add(StepsSimulationClick(id, DateTime.now())),
      onPointerUp: (event) =>
          stepsSimulationBloc.add(StepsSimulationClickEnd(id, DateTime.now())),
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
