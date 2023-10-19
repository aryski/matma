import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';
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
            child: AnimatedOpacity(
              opacity: state.opacity,
              duration: const Duration(milliseconds: 200),
              child: DefaultTweenAnimationBuilder(
                initial: initialState.size,
                updated: state.size,
                builder: (context, size, child) {
                  var tweenState = state.copy()..size = size;
                  return SizedBox(
                    width:
                        tweenState.size.dx * MediaQuery.of(context).size.width,
                    height:
                        tweenState.size.dy * MediaQuery.of(context).size.height,
                    child: Container(
                      color: Colors.grey.withOpacity(0.0),
                      child: Center(
                        child: Text(
                          tweenState.value == Signs.addition ? "+" : "-",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: tweenState.size.dx *
                                  MediaQuery.of(context).size.width),
                        ),
                      ),
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
