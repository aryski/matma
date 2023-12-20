import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/items/shadow_number/cubit/shadow_number_cubit.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';

class ShadowNumber extends StatelessWidget {
  const ShadowNumber({super.key, required this.cubit});
  final ShadowNumberCubit cubit;

  @override
  Widget build(BuildContext context) {
    ShadowNumberState initialState = cubit.state.copyWith();

    return BlocProvider<ShadowNumberCubit>(
        create: (context) => cubit,
        child: BlocBuilder<ShadowNumberCubit, ShadowNumberState>(
            builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return TweenAnimatedPosition(
                halfWidthOffset: true,
                halfHeightOffset: false,
                duration: Duration(milliseconds: state.position.duration),
                initialPosition: initialState.position.value.scale(1, 1),
                updatedPosition: state.position.value.scale(1, 1),
                child: DefaultTweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1000),
                  initial: 0,
                  updated: 1.0,
                  builder: (context, opacity, child) {
                    return Opacity(
                      opacity: opacity < 0.5 ? opacity * 2 : (1 - opacity) * 2,
                      child: Container(
                        color: const Color.fromARGB(255, 255, 201, 201)
                            .withOpacity(0.0),
                        child: Center(
                          child: Text(
                            state.value,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.3),
                                fontWeight: FontWeight.bold,
                                fontSize: 45.0),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }));
  }
}
