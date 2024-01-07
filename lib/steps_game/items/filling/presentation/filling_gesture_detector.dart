import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/filling/cubit/filling_cubit.dart';

class FillingGestureDetector extends StatelessWidget {
  const FillingGestureDetector(
      {super.key, required this.child, required this.id});
  final Widget child;
  final UniqueKey id;

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<StepsGameBloc>();
    return Listener(
      onPointerDown: (event) {
        bloc.add(StepsTrigEventClickFilling(id: id));
      },
      behavior: HitTestBehavior.deferToChild,
      child: MouseRegion(
        // hitTestBehavior: HitTestBehavior.deferToChild,
        onEnter: (event) {
          hoverKepper = id;
          context.read<FillingCubit>().hoverStart();
        },
        onExit: (event) {
          hoverKepper = null;
          context.read<FillingCubit>().hoverEnd();
        },
        child: child,
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   var bloc = context.read<StepsGameBloc>();
  //   var id = context.read<ArrowCubit>().state.id;

  //   return Listener(
  //     onPointerDown: (event) =>
  //         bloc.add(StepsTrigEventClickDown(id: id, time: DateTime.timestamp())),
  //     onPointerUp: (event) =>
  //         bloc.add(StepsTrigEventClickUp(id: id, time: DateTime.timestamp())),
  //     behavior: HitTestBehavior.deferToChild,
  //     child: MouseRegion(
  //       hitTestBehavior: HitTestBehavior.deferToChild,
  //       onEnter: (event) {
  //         hoverKepper = id;
  //         context.read<ArrowCubit>().hoverStart();
  //       },
  //       onExit: (event) {
  //         hoverKepper = null;
  //         context.read<ArrowCubit>().hoverEnd();
  //       },
  //       child: child,
  //     ),
  //   );
  // }
}
