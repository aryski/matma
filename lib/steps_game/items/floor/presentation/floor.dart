import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/animations/default_color_animation_builder.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';

import 'package:matma/steps_game/items/floor/presentation/floor_gesture_detector.dart';
import 'package:matma/steps_game/items/floor/presentation/floor_painter.dart';

Color _colorGen(FloorState state, bool isHovered) {
  if (state.isLastInGame) {
    return isHovered ? shadyDefYellow : defYellow;
  } else if (state.isLastInNumber) {
    return isHovered ? shadyDefGrey : defGrey;
  } else if (state.direction == Direction.up) {
    return isHovered ? shadyDarkGreen : darkGreen;
  } else if (state.direction == Direction.down) {
    return isHovered ? shadyDarkRed : darkRed;
  } else {
    return defGrey;
  }
}

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
              return FloorGestureDetector(
                  id: state.id,
                  child: DefaultColorAnimationBuilder(
                    duration: const Duration(milliseconds: 400),
                    initial: _colorGen(state, initialState.isHovered),
                    updated: _colorGen(state, state.isHovered),
                    builder: (context, color, child) {
                      return CustomPaint(
                        size: Size(constrains.maxWidth, constrains.maxHeight),
                        painter: FloorPainter(
                          constrains.maxWidth,
                          constrains.maxHeight,
                          state.radius * MediaQuery.of(context).size.width,
                          color ?? defGrey,
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
