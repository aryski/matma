import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/equation/items/shadow_number/cubit/shadow_number_cubit.dart';
import 'package:matma/common/items/animations/default_tween_animation_builder.dart';
import 'package:matma/equation/constants.dart' as constants;

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
          return DefaultGameItemAnimations(
            halfWidthOffset: true,
            halfHeightOffset: false,
            initialState: initialState,
            state: state,
            child: LayoutBuilder(builder: (context, constrains) {
              return DefaultTweenAnimationBuilder(
                duration: const Duration(milliseconds: 1000),
                initial: 0.0,
                updated: 1.0,
                builder: (context, opacity, child) {
                  return SizedBox(
                    width: constrains.maxWidth,
                    height: constrains.maxHeight,
                    child: _ShadowNumberDesign(state: state, opacity: opacity),
                  );
                },
              );
            }),
          );
        },
      ),
    );
  }
}

class _ShadowNumberDesign extends StatelessWidget {
  const _ShadowNumberDesign({required this.opacity, required this.state});
  final double opacity;
  final ShadowNumberState state;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity < 0.5 ? opacity * 2 : (1 - opacity) * 2,
      child: Container(
        color: const Color.fromARGB(255, 201, 255, 234).withOpacity(0.0),
        child: Center(
          child: Text(
            state.value,
            style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
                fontWeight: FontWeight.bold,
                fontSize: constants.fontSizeSmall),
          ),
        ),
      ),
    );
  }
}
