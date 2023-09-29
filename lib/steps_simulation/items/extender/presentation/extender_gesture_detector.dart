import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:matma/steps_simulation/items/extender/cubit/extender_cubit.dart';

class ExtenderGestureDetector extends StatelessWidget {
  const ExtenderGestureDetector({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var id = context.read<ExtenderCubit>().state.id;
    return MouseRegion(
      onEnter: (event) {
        hoverKepper = id;
        context.read<ExtenderCubit>().hoverStart();
      },
      onExit: (event) {
        hoverKepper = null;
        context.read<ExtenderCubit>().hoverEnd();
      },
      child: child,
    );
  }
}
