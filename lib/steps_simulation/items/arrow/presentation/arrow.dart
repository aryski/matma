import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_simulation/items/arrow/presentation/arrow_controls.dart';
import 'package:matma/steps_simulation/items/arrow/presentation/arrow_painter.dart';

class Arrow extends StatelessWidget {
  const Arrow({super.key, required this.cubit});
  final ArrowCubit cubit;

  @override
  Widget build(BuildContext context) {
    final initialState = cubit.state.copy();
    return BlocProvider<ArrowCubit>(
      create: (context) => cubit,
      child: BlocBuilder<ArrowCubit, ArrowState>(
        builder: (context, state) {
          return TweenAnimatedPosition(
            initialPosition: initialState.position,
            updatedPosition: state.position,
            child: AnimatedOpacity(
              opacity: state.opacity,
              duration: Duration(milliseconds: 200),
              child: DefaultTweenAnimationBuilder(
                  initial: initialState.animProgress,
                  updated: state.animProgress,
                  builder: (context, animationProgress, child) {
                    return DefaultTweenAnimationBuilder(
                        initial: initialState.size,
                        updated: state.size,
                        builder: (context, size, child) {
                          var tweenState = state.copy()..size = size;
                          return ArrowGestureDetector(
                            child: CustomPaint(
                              size:
                                  Size(tweenState.size.dx, tweenState.size.dy),
                              painter: ArrowPainter(tweenState,
                                  initialState.size, animationProgress),
                            ),
                          );
                        });
                  }),
            ),
          );
        },
      ),
    );
  }
}
