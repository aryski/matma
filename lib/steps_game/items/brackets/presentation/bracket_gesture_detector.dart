import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/brackets/cubit/bracket_cubit.dart';

class BracketGestureDetector extends StatelessWidget {
  const BracketGestureDetector(
      {super.key, required this.child, required this.id});
  final Widget child;
  final UniqueKey id;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        hoverKepper = id;
        context.read<BracketCubit>().hoverStart();
      },
      onExit: (event) {
        hoverKepper = null;
        context.read<BracketCubit>().hoverEnd();
      },
      child: child,
    );
  }
}
