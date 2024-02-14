import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/equation/items/board/cubit/board_cubit.dart';
import 'package:matma/equation/items/board/presentation/board_design.dart';

class Board extends StatelessWidget {
  const Board({super.key, required this.cubit});
  final BoardCubit cubit;

  @override
  Widget build(BuildContext context) {
    BoardState initialState = cubit.state.copyWith();

    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocProvider<BoardCubit>(
          create: (context) => cubit,
          child: BlocBuilder<BoardCubit, BoardState>(
            builder: (context, state) {
              return DefaultGameItemAnimations(
                halfWidthOffset: true,
                halfHeightOffset: false,
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
