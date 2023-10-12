import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';

class FloorGestureDetector extends StatelessWidget {
  const FloorGestureDetector(
      {super.key, required this.child, required this.id});
  final Widget child;
  final UniqueKey id;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        //print("ADDING HOVER KEEPER ID");
        //print("$id");
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
