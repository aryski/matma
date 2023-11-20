import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/equation/items/number/cubit/number_cubit.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';

class Number extends StatelessWidget {
  const Number({super.key, required this.cubit});
  final NumberCubit cubit;

  @override
  Widget build(BuildContext context) {
    NumberState initialState = cubit.state.copyWith();

    return BlocProvider<NumberCubit>(
      create: (context) => cubit,
      child: BlocBuilder<NumberCubit, NumberState>(
        builder: (context, state) {
          return DefaultGameItemAnimations(
            initialState: initialState,
            state: state,
            child: LayoutBuilder(builder: (context, constrains) {
              return Row(
                children: [
                  SizedBox(
                    width: constrains.maxWidth,
                    height: constrains.maxHeight,
                    child: Container(
                      color: const Color.fromARGB(255, 255, 201, 201)
                          .withOpacity(0.0),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: AnimatedSwitcher(
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
                            child: Center(
                              key: state.textKey,
                              child: Stack(
                                children: [
                                  Text(
                                    state.value.abs().toString(),
                                    style: TextStyle(
                                        color: state.withDarkenedColor
                                            ? ((state.sign == Signs.addition)
                                                ? defaultBackground
                                                : defaultBackground)
                                            : ((state.sign == Signs.addition)
                                                ? defGreen
                                                : defRed),
                                        fontWeight: FontWeight.bold,
                                        fontSize: state.size.value.dx *
                                            MediaQuery.of(context).size.width),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}
