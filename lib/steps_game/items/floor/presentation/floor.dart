import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';

import 'package:matma/steps_game/items/floor/presentation/floor_gesture_detector.dart';
import 'package:matma/steps_game/items/floor/presentation/floor_painter.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';

class Floor extends StatelessWidget {
  const Floor({super.key, required this.cubit});
  final FloorCubit cubit;

  @override
  Widget build(BuildContext context) {
    FloorState initialState = cubit.state.copy();

    return BlocProvider<FloorCubit>(
      create: (context) => cubit,
      child: BlocBuilder<FloorCubit, FloorState>(
        builder: (context, state) {
          return TweenAnimatedPosition(
            initialPosition: initialState.position,
            updatedPosition: state.position,
            child: DefaultTweenAnimationBuilder(
              initial: initialState.size,
              updated: state.size,
              builder: (context, size, child) {
                var tweenState = state.copy()..size = size;
                return FloorGestureDetector(
                  id: state.id,
                  child: CustomPaint(
                    size: Size(
                        tweenState.size.dx * MediaQuery.of(context).size.width,
                        tweenState.size.dy *
                            MediaQuery.of(context).size.height),
                    painter: FloorPainter(
                        tweenState.size.dx * MediaQuery.of(context).size.width,
                        tweenState.size.dy * MediaQuery.of(context).size.height,
                        state.radius * MediaQuery.of(context).size.width,
                        state.isLast
                            ? (state.color == GameItemColor.hover
                                ? darkenColor(defaultYellow, 20)
                                : defaultYellow)
                            : (state.color == GameItemColor.hover
                                ? darkenColor(defaultGrey, 20)
                                : defaultGrey)),
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
