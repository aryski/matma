import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/animations/default_color_animation_builder.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';
import 'package:matma/steps_game/bloc/constants.dart' as constants;

import 'package:matma/steps_game/items/floor/presentation/floor_gesture_detector.dart';
import 'package:matma/steps_game/items/floor/presentation/floor_painter.dart';

Color _colorGen(BuildContext context, FloorState state, bool isHovered) {
  var color = Color.alphaBlend(
      Theme.of(context).colorScheme.onSecondaryContainer.withOpacity(0.8),
      Theme.of(context).colorScheme.background);
  if (state.colors.value == FloorColors.def) {
    if (state.isLastInNumber) {
      return isHovered ? darkenColor(color, 0.1) : darkenColor(color, 0.0);
    } else if (state.direction == Direction.up) {
      return isHovered ? darkenColor(darkGreen, 0.2) : darkGreen;
    } else if (state.direction == Direction.down) {
      return isHovered ? darkenColor(darkRed, 0.2) : darkRed;
    } else {
      return color;
    }
  } else if (state.colors.value == FloorColors.special) {
    return isHovered ? shadyDefYellow : defYellow;
  }
  return color;
}

// double _updateTime(FloorState state, bool isHovered) {
//   if (state.isLastInGame) {
//     return isHovered ? shadyDefYellow : defYellow;
//   } else if (state.isLastInNumber) {
//     return isHovered ? darkenColor(color, 0.1) : darkenColor(color, 0.0);
//   } else if (state.direction == Direction.up) {
//     return isHovered ? darkenColor(darkGreen, 0.2) : darkGreen;
//   } else if (state.direction == Direction.down) {
//     return isHovered ? darkenColor(darkRed, 0.2) : darkRed;
//   } else {
//     return color;
//   }
// }

class Floor extends StatelessWidget {
  const Floor({super.key, required this.cubit});
  final FloorCubit cubit;

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
            child: LayoutBuilder(builder: (context, constrains) {
              var initColor = _colorGen(context, state, initialState.isHovered);
              var updatedColor = _colorGen(context, state, state.isHovered);

              return FloorGestureDetector(
                  id: state.id,
                  child: DefaultColorAnimationBuilder(
                    duration: Duration(milliseconds: state.colors.duration),
                    initial: initColor,
                    updated: updatedColor,
                    builder: (context, color, child) {
                      return CustomPaint(
                        size: Size(constrains.maxWidth, constrains.maxHeight),
                        painter: FloorPainter(
                            constrains.maxWidth,
                            constrains.maxHeight,
                            constants.radius * constrains.maxHeight * 0.05,
                            color ?? initColor),
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
