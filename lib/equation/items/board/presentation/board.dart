import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/items/board/cubit/board_cubit.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';

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
          return TweenAnimatedPosition(
            initialPosition: initialState.position,
            updatedPosition: state.position,
            child: AnimatedOpacity(
              opacity: state.opacity,
              duration: const Duration(milliseconds: 200),
              child: DefaultTweenAnimationBuilder(
                initial: initialState.size,
                updated: state.size,
                builder: (context, size, child) {
                  var tweenState = state.copy()..size = size;
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(state.radius),
                    child: Container(
                      color: state.color,
                      width: tweenState.size.dx *
                          MediaQuery.of(context).size.width,
                      height: tweenState.size.dy *
                          MediaQuery.of(context).size.height,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
