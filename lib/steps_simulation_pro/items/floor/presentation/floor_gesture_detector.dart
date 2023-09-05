import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_cubit.dart';

class FloorGestureDetector extends StatelessWidget {
  const FloorGestureDetector({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var id = context.read<FloorCubit>().state.id;
    return MouseRegion(
      onEnter: (event) {
        hoverKepper = id;
        context.read<FloorCubit>().hoverStart();
      },
      onExit: (event) {
        hoverKepper = null;
        context.read<FloorCubit>().hoverEnd();
      },
      child: child,
    );
  }
}
