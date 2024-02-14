import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/equation/items/value/cubit/value_cubit.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/equation/constants.dart' as constants;

class Value extends StatelessWidget {
  const Value({super.key, required this.cubit});
  final ValueCubit cubit;

  @override
  Widget build(BuildContext context) {
    ValueState initialState = cubit.state.copyWith();

    return BlocProvider<ValueCubit>(
      create: (context) => cubit,
      child: BlocBuilder<ValueCubit, ValueState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            halfWidthOffset: true,
            halfHeightOffset: false,
            initialState: initialState,
            state: state,
            child: LayoutBuilder(builder: (context, constrains) {
              return AnimatedSwitcher(
                  key: state.id,
                  switchInCurve: Curves.ease,
                  switchOutCurve: Curves.ease,
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns: animation,
                      child: ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                    );
                  },
                  duration: const Duration(milliseconds: 200),
                  child: SizedBox(
                    key: state.switcherKey,
                    width: constrains.maxWidth,
                    height: constrains.maxHeight,
                    child: _ValueDesign(state: state),
                  ));
            }),
          );
        },
      ),
    );
  }
}

class _ValueDesign extends StatelessWidget {
  const _ValueDesign({required this.state});
  final ValueState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 201, 201).withOpacity(0.0),
      child: Center(
          child: Text(
        state.value.abs().toString(),
        style: TextStyle(
            color: state.withDarkenedColor
                ? Theme.of(context).colorScheme.onSecondaryContainer
                : ((state.sign == Signs.addition) ? defGreen : defRed),
            fontWeight: FontWeight.bold,
            fontSize: constants.fontSize),
      )),
    );
  }
}
