import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';
import 'package:matma/steps_simulation/items/extender/cubit/extender_cubit.dart';
import 'package:matma/steps_simulation/items/extender/presentation/extender_gesture_detector.dart';
import 'package:matma/steps_simulation/items/extender/presentation/extender_painter.dart';

import 'package:matma/common/items/animations/default_tween_animation_builder.dart';

class Extender extends StatelessWidget {
  const Extender({super.key, required this.cubit});
  final ExtenderCubit cubit;

  @override
  Widget build(BuildContext context) {
    ExtenderState initialState = cubit.state.copy();

    return BlocProvider<ExtenderCubit>(
      create: (context) => cubit,
      child: BlocBuilder<ExtenderCubit, ExtenderState>(
        builder: (context, state) {
          return TweenAnimatedPosition(
            initialPosition: initialState.position,
            updatedPosition: state.position,
            child: DefaultTweenAnimationBuilder(
              initial: initialState.size,
              updated: state.size,
              builder: (context, size, child) {
                var tweenState = state.copy()..size = size;
                return ExtenderGestureDetector(
                  child: CustomPaint(
                    size: Size(tweenState.size.dx, tweenState.size.dy),
                    painter: ExtenderPainter(tweenState),
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
