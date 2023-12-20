import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/animations/default_color_animation_builder.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/steps_game/items/filling/cubit/filling_cubit.dart';
import 'package:matma/steps_game/items/filling/presentation/filling_gesture_detector.dart';
import 'package:matma/steps_game/items/filling/presentation/filling_painter.dart';

class Filling extends StatelessWidget {
  const Filling({super.key, required this.cubit});
  final FillingCubit cubit;

  @override
  Widget build(BuildContext context) {
    FillingState initialState = cubit.state.copyWith();

    return BlocProvider<FillingCubit>(
      create: (context) => cubit,
      child: BlocBuilder<FillingCubit, FillingState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            initialState: initialState,
            state: state,
            child: DefaultTweenAnimationBuilder(
                duration: const Duration(milliseconds: 200),
                initial: initialState.animProgress,
                updated: state.animProgress,
                builder: (context, animationProgress, child) {
                  return DefaultTweenAnimationBuilder(
                      duration: const Duration(milliseconds: 200),
                      initial: initialState.size.value.dx,
                      updated: state.size.value.dx,
                      builder: (context, dx, child) {
                        return LayoutBuilder(builder: (context, constrains) {
                          return FillingGestureDetector(
                              id: state.id,
                              child: DefaultColorAnimationBuilder(
                                duration: const Duration(milliseconds: 50),
                                initial: initialState.isHovered
                                    ? darkenColor(
                                        Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                        0.1)
                                    : Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                updated: state.isHovered
                                    ? darkenColor(
                                        Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                        0.1)
                                    : Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                builder: (context, color, child) {
                                  return CustomPaint(
                                    size: Size(constrains.maxWidth,
                                        constrains.maxHeight),
                                    painter: FillingPainter(
                                      stepHgt: state.stepHgt,
                                      animProgress: animationProgress,
                                      steps: state.steps,
                                      width: dx,
                                      stepWdt: state.stepWdt,
                                      radius: state.radius,
                                      color: color ??
                                          Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                    ),
                                  );
                                },
                              ));
                        });
                      });
                }),
          );
        },
      ),
    );
  }
}
