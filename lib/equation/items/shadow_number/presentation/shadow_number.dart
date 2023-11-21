import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/equation/items/shadow_number/cubit/shadow_number_cubit.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';
import 'package:matma/common/items/animations/tween_animated_position.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

class ShadowNumber extends StatelessWidget {
  const ShadowNumber({super.key, required this.cubit, required this.gs});
  final ShadowNumberCubit cubit;
  final GameSize gs;

  @override
  Widget build(BuildContext context) {
    ShadowNumberState initialState = cubit.state.copyWith();

    return BlocProvider<ShadowNumberCubit>(
      create: (context) => cubit,
      child: BlocBuilder<ShadowNumberCubit, ShadowNumberState>(
        builder: (context, state) {
          return TweenAnimatedPosition(
            duration: const Duration(milliseconds: 1000),
            initialPosition:
                initialState.position.value.scale(gs.wUnit, gs.hUnit),
            updatedPosition: state.position.value.scale(gs.wUnit, gs.hUnit),
            child: DefaultTweenAnimationBuilder(
              duration: const Duration(milliseconds: 1000),
              initial: 0,
              updated: 1.0,
              builder: (context, opacity, child) {
                return Row(
                  children: [
                    SizedBox(
                      width: state.size.value.dx *
                          gs.wUnit *
                          MediaQuery.of(context).size.width,
                      height: state.size.value.dy *
                          gs.hUnit *
                          MediaQuery.of(context).size.height,
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
                                  color: defGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: state.size.value.dx *
                                      gs.wUnit *
                                      MediaQuery.of(context).size.width *
                                      3 /
                                      4),
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
