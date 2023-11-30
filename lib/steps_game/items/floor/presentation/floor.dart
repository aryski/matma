import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/animations/default_color_animation_builder.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/common/game_size.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';

import 'package:matma/steps_game/items/floor/presentation/floor_gesture_detector.dart';
import 'package:matma/steps_game/items/floor/presentation/floor_painter.dart';

Color _colorGen(BuildContext context, FloorState state, bool isHovered) {
  if (state.isLastInGame) {
    return isHovered ? shadyDefYellow : defYellow;
  } else if (state.isLastInNumber) {
    return isHovered
        ? darkenColor(Theme.of(context).colorScheme.secondaryContainer, 0.3)
        : darkenColor(Theme.of(context).colorScheme.secondaryContainer, 0.2);
  } else if (state.direction == Direction.up) {
    return isHovered ? darkenColor(darkGreen, 0.2) : darkGreen;
  } else if (state.direction == Direction.down) {
    return isHovered ? darkenColor(darkRed, 0.2) : darkRed;
  } else {
    return Theme.of(context).colorScheme.secondaryContainer;
  }
}

class Floor extends StatelessWidget {
  const Floor({super.key, required this.cubit, required this.gs});
  final FloorCubit cubit;
  final GameSize gs;
  @override
  Widget build(BuildContext context) {
    FloorState initialState = cubit.state.copyWith();

    return BlocProvider<FloorCubit>(
      create: (context) => cubit,
      child: BlocBuilder<FloorCubit, FloorState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            initialState: initialState,
            state: state,
            gs: gs,
            child: LayoutBuilder(builder: (context, constrains) {
              return FloorGestureDetector(
                  id: state.id,
                  child: DefaultColorAnimationBuilder(
                    duration: const Duration(milliseconds: 400),
                    initial: _colorGen(context, state, initialState.isHovered),
                    updated: _colorGen(context, state, state.isHovered),
                    builder: (context, color, child) {
                      return CustomPaint(
                        size: Size(constrains.maxWidth, constrains.maxHeight),
                        painter: FloorPainter(
                          constrains.maxWidth,
                          constrains.maxHeight,
                          state.radius * constrains.maxHeight * 0.9,
                          color ??
                              Theme.of(context).colorScheme.secondaryContainer,
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
