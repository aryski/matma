import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/shadow_number/cubit/shadow_number_cubit.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';

class ShadowNumber extends StatelessWidget {
  const ShadowNumber({super.key, required this.cubit});
  final ShadowNumberCubit cubit;

  @override
  Widget build(BuildContext context) {
    ShadowNumberState initialState = cubit.state.copy();

    return BlocProvider<ShadowNumberCubit>(
      create: (context) => cubit,
      child: BlocBuilder<ShadowNumberCubit, ShadowNumberState>(
        builder: (context, state) {
          return TweenAnimatedPosition(
            duration: Duration(milliseconds: 1000),
            initialPosition: initialState.position,
            updatedPosition: state.position,
            child: DefaultTweenAnimationBuilder(
              duration: Duration(milliseconds: 1000),
              initial: 0,
              updated: 1.0,
              builder: (context, opacity, child) {
                return Row(
                  children: [
                    SizedBox(
                      width: state.size.dx,
                      height: state.size.dy,
                      child: Opacity(
                        opacity:
                            opacity < 0.5 ? opacity * 2 : (1 - opacity) * 2,
                        child: Container(
                          color: const Color.fromARGB(255, 255, 201, 201)
                              .withOpacity(0.0),
                          child: Center(
                            child: Text(
                              state.value,
                              style: TextStyle(
                                  color: state.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: state.size.dx * 3 / 4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
