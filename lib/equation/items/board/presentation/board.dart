import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/equation/items/board/cubit/board_cubit.dart';
import 'package:matma/common/game_size.dart';

class Board extends StatelessWidget {
  const Board({super.key, required this.cubit, required this.gs});
  final BoardCubit cubit;
  final GameSize gs;
  @override
  Widget build(BuildContext context) {
    BoardState initialState = cubit.state.copyWith();

    return BlocProvider<BoardCubit>(
      create: (context) => cubit,
      child: BlocBuilder<BoardCubit, BoardState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            gs: gs,
            initialState: initialState,
            state: state,
            child: LayoutBuilder(builder: (context, constrains) {
              return BoardDesign(
                width: constrains.maxWidth,
                height: constrains.maxHeight,
                radius: state.radius,
                fillColor: Theme.of(context).colorScheme.secondaryContainer,
                frameColor: Theme.of(context).colorScheme.onSecondaryContainer,
              );
            }),
          );
        },
      ),
    );
  }
}

class BoardDesign extends StatelessWidget {
  const BoardDesign({
    super.key,
    required this.width,
    required this.height,
    required this.radius,
    required this.frameColor,
    required this.fillColor,
  });
  final double width;
  final double height;
  final double radius;
  final Color frameColor;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius + 5),
      child: Container(
        color: frameColor,
        width: width,
        height: height,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              color: fillColor,
              width: width - 10,
              height: height - 10,
            ),
          ),
        ),
      ),
    );
  }
}
