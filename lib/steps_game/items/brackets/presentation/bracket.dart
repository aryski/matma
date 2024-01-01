import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/animations/default_color_animation_builder.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/steps_game/items/brackets/cubit/bracket_cubit.dart';
import 'package:matma/steps_game/items/brackets/cubit/bracket_state.dart';
import 'package:matma/steps_game/items/brackets/presentation/bracket_gesture_detector.dart';
import 'package:matma/steps_game/items/brackets/presentation/bracket_painter.dart';
import 'package:matma/steps_game/bloc/constants.dart' as constants;

class Bracket extends StatelessWidget {
  const Bracket({super.key, required this.cubit});
  final BracketCubit cubit;

  @override
  Widget build(BuildContext context) {
    BracketState initialState = cubit.state.copyWith();

    return BlocProvider<BracketCubit>(
      create: (context) => cubit,
      child: BlocBuilder<BracketCubit, BracketState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            initialState: initialState,
            state: state,
            child: LayoutBuilder(builder: (context, constrains) {
              var initColor =
                  Theme.of(context).colorScheme.onSecondaryContainer;
              var updatedColor =
                  Theme.of(context).colorScheme.onSecondaryContainer;
              return BracketGestureDetector(
                  id: state.id,
                  child: DefaultColorAnimationBuilder(
                    duration: const Duration(milliseconds: 400),
                    initial: initColor,
                    updated: updatedColor,
                    builder: (context, color, child) {
                      return Container(
                        // color: Colors.redAccent,
                        child: CustomPaint(
                          size: Size(constrains.maxWidth, constrains.maxHeight),
                          painter: BracketPainter(
                              constrains.maxWidth,
                              constrains.maxHeight,
                              constants.radius * constrains.maxHeight * 0.9,
                              color ?? initColor,
                              state.direction,
                              state.heightOffset),
                        ),
                      );
                    },
                  ));
            }),
          );
        },
      ),
    );
  }
}
