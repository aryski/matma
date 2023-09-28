import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';
import 'package:matma/steps_simulation/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_simulation/items/equator/presentation/equator_painter.dart';

import 'package:matma/common/items/animations/default_tween_animation_builder.dart';

class Equator extends StatelessWidget {
  const Equator({super.key, required this.cubit});
  final EquatorCubit cubit;

  @override
  Widget build(BuildContext context) {
    EquatorState initialState = cubit.state.copy();

    return BlocProvider<EquatorCubit>(
      create: (context) => cubit,
      child: BlocBuilder<EquatorCubit, EquatorState>(
        builder: (context, state) {
          return TweenAnimatedPosition(
            initialPosition: initialState.position,
            updatedPosition: state.position,
            child: DefaultTweenAnimationBuilder(
              initial: initialState.size,
              updated: state.size,
              builder: (context, size, child) {
                var tweenState = state.copy()..size = size;
                return CustomPaint(
                  size: Size(tweenState.size.dx, tweenState.size.dy),
                  painter: EquatorPainter(tweenState),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
