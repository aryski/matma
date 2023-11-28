import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/common/game_size.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/arrow/presentation/arrow_controls.dart';
import 'package:matma/steps_game/items/arrow/presentation/arrow_painter.dart';

class Arrow extends StatelessWidget {
  const Arrow({super.key, required this.cubit, required this.gs});
  final ArrowCubit cubit;
  final GameSize gs;

  @override
  Widget build(BuildContext context) {
    final initialState = cubit.state.copyWith();
    return BlocProvider<ArrowCubit>(
      create: (context) => cubit,
      child: BlocBuilder<ArrowCubit, ArrowState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            initialState: initialState,
            state: state,
            gs: gs,
            child: DefaultTweenAnimationBuilder(
                duration: const Duration(milliseconds: 200),
                initial: initialState.animProgress,
                updated: state.animProgress,
                builder: (context, animationProgress, child) {
                  return ArrowGestureDetector(
                    child: LayoutBuilder(builder: (context, constrains) {
                      return CustomPaint(
                        size: Size(constrains.maxWidth, constrains.maxHeight),
                        painter: ArrowPainter(
                            constrains.maxWidth,
                            constrains.maxHeight,
                            state.radius *
                                gs.wUnit *
                                MediaQuery.of(context).size.width,
                            state.direction == Direction.up
                                ? (state.isHovered ? shadyDefGreen : defGreen)
                                : (state.isHovered ? shadyDefRed : defRed),
                            state.direction,
                            animationProgress),
                      );
                    }),
                  );
                }),
          );
        },
      ),
    );
  }
}
