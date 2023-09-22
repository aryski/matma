import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';

class Number extends StatelessWidget {
  const Number({super.key, required this.cubit});
  final NumberCubit cubit;

  @override
  Widget build(BuildContext context) {
    NumberState initialState = cubit.state.copy();

    return BlocProvider<NumberCubit>(
      create: (context) => cubit,
      child: BlocBuilder<NumberCubit, NumberState>(
        builder: (context, state) {
          return TweenAnimatedPosition(
            initialPosition: initialState.position,
            updatedPosition: state.position,
            child: DefaultTweenAnimationBuilder(
              initial: initialState.size,
              updated: state.size,
              builder: (context, size, child) {
                var tweenState = state.copy()..size = size;
                return SizedBox(
                  width: tweenState.size.dx,
                  height: tweenState.size.dy,
                  child: Container(
                    color: Colors.red,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: AnimatedSwitcher(
                          key: state.id,
                          switchInCurve: Curves.ease,
                          switchOutCurve: Curves.ease,
                          transitionBuilder: (child, animation) {
                            return RotationTransition(
                              turns: animation,
                              child: ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                            );
                          },
                          duration: const Duration(milliseconds: 200),
                          child: Center(
                            key: UniqueKey(),
                            child: Text(
                              tweenState.value.abs().toString(),
                              style: TextStyle(
                                  color: Colors.amber[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: tweenState.size.dx),
                            ),
                          )),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
