import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/common/items/game_item/default_game_item_animations.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';

import 'package:matma/steps_game/items/floor/presentation/floor_gesture_detector.dart';
import 'package:matma/steps_game/items/floor/presentation/floor_painter.dart';

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
          return DefaultGameItemAnimations(
            initialState: initialState,
            state: state,
            child: LayoutBuilder(builder: (context, constrains) {
              return FloorGestureDetector(
                id: state.id,
                child: CustomPaint(
                  size: Size(constrains.maxWidth, constrains.maxHeight),
                  painter: FloorPainter(
                      constrains.maxWidth,
                      constrains.maxHeight,
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
            }),
          );
        },
      ),
    );
  }
}
