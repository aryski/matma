import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';

class FloorGestureDetector extends StatelessWidget {
  const FloorGestureDetector(
      {super.key, required this.child, required this.id});
  final Widget child;
  final UniqueKey id;

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<StepsGameBloc>();
    var id = context.read<FloorCubit>().state.id;
    return Listener(
      onPointerDown: (event) => bloc.add(StepsTrigEventClickFloor(id: id)),
      onPointerUp: (event) => bloc.add(StepsTrigEventClickFloor(id: id)),
      behavior: HitTestBehavior.deferToChild,
      child: MouseRegion(
        onEnter: (event) {
          hoverKepper = id;
          context.read<FloorCubit>().hoverStart();
        },
        onExit: (event) {
          hoverKepper = null;
          context.read<FloorCubit>().hoverEnd();
        },
        child: child,
      ),
    );
  }
}
