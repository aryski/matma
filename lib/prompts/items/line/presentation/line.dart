import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/game_item/default_game_item_animations.dart';
import 'package:matma/prompts/items/line/cubit/line_cubit.dart';

class Line extends StatelessWidget {
  const Line({super.key, required this.cubit});
  final LineCubit cubit;

  @override
  Widget build(BuildContext context) {
    final initialState = cubit.state.copyWith();
    return BlocProvider<LineCubit>(
      create: (context) => cubit,
      child: BlocBuilder<LineCubit, LineState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
              initialState: initialState,
              state: state,
              child: Center(
                child: Container(
                  color: defaultBackground,
                  child: Text(
                    state.text,
                    key: state.id,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                ),
              )

              //  LayoutBuilder(
              //   builder: (context, constrains) {
              //     return CustomPaint(
              //       size: Size(constrains.maxWidth, constrains.maxHeight),
              //       painter: LinePainter(
              //           constrains.maxWidth,
              //           constrains.maxHeight,
              //           state.radius * MediaQuery.of(context).size.width,
              //           state.direction == Direction.up
              //               ? (state.isHovered
              //                   ? darkenColor(defaultGreen, 20)
              //                   : defaultGreen)
              //               : (state.isHovered
              //                   ? darkenColor(defaultRed, 20)
              //                   : defaultRed),
              //           state.direction,
              //           animationProgress),
              //     );
              //   },
              // ),
              );
        },
      ),
    );
  }
}
