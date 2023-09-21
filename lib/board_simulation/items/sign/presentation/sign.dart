import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';

class Sign extends StatelessWidget {
  const Sign({super.key, required this.cubit});
  final SignCubit cubit;

  @override
  Widget build(BuildContext context) {
    SignState initialState = cubit.state.copy();

    return BlocProvider<SignCubit>(
      create: (context) => cubit,
      child: BlocBuilder<SignCubit, SignState>(
        builder: (context, state) {
          return TweenAnimatedPosition(
            initialPosition: initialState.position,
            updatedPosition: state.position,
            child: DefaultTweenAnimationBuilder(
              initial: initialState.size,
              updated: state.size,
              builder: (context, size, child) {
                var tweenState = state.copy()..size = size;
                return SizedBox(
                  width: tweenState.size.dx,
                  height: tweenState.size.dy,
                  child: FittedBox(
                    child: Text(
                      tweenState.value == Signs.addition ? "+" : "-",
                      style: TextStyle(
                          color: Colors.amber[900],
                          fontWeight: FontWeight.bold),
                    ),
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
