import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/equation/items/board/cubit/board_cubit.dart';

class Board extends StatelessWidget {
  const Board({super.key, required this.cubit});
  final BoardCubit cubit;

  @override
  Widget build(BuildContext context) {
    BoardState initialState = cubit.state.copyWith();

    return LayoutBuilder(
      builder: (context, constraints) {
        // print("LBB ${constraints.maxWidth} x ${constraints.maxHeight}");

        return BlocProvider<BoardCubit>(
          create: (context) => cubit,
          child: BlocBuilder<BoardCubit, BoardState>(
            builder: (context, state) {
              return DefaultGameItemAnimations(
                halfWidthOffset: true,
                noResize: true,
                initialState: initialState,
                state: state,
                child: LayoutBuilder(builder: (context, constrains) {
                  return BoardDesign(
                    fillColor: Theme.of(context).colorScheme.secondaryContainer,
                    frameColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                  );
                }),
              );
            },
          ),
        );
      },
    );
  }
}

class BoardDesign extends StatelessWidget {
  const BoardDesign({
    super.key,
    required this.frameColor,
    required this.fillColor,
  });

  final Color frameColor;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(constrains.maxHeight * 0.16),
          child: Container(
            color: frameColor,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(constrains.maxHeight * 0.05),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      constrains.maxHeight * 0.16 -
                          constrains.maxHeight * 0.05),
                  child: Container(
                    color: fillColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
