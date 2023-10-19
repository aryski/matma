import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/game_item/default_game_item_animations.dart';
import 'package:matma/equation/items/board/cubit/board_cubit.dart';

class Board extends StatelessWidget {
  const Board({super.key, required this.cubit});
  final BoardCubit cubit;

  @override
  Widget build(BuildContext context) {
    BoardState initialState = cubit.state.copy();

    return BlocProvider<BoardCubit>(
      create: (context) => cubit,
      child: BlocBuilder<BoardCubit, BoardState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            initialState: initialState,
            state: state,
            child: LayoutBuilder(builder: (context, constrains) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(state.radius),
                child: Container(
                  color: defaultEquator,
                  width: constrains.maxWidth,
                  height: constrains.maxHeight,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
