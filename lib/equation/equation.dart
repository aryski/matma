import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/equation/items/items.dart';

class Equation extends StatelessWidget {
  const Equation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Flexible(
          flex: 3,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Center(
                child: SizedBox(
                  height: 224 * 3 / 4,
                  width: 1920,
                  child: Center(
                    child: BlocBuilder<EquationBloc, EquationState>(
                        builder: (context, state) {
                      return LayoutBuilder(builder: ((context, constraints) {
                        // print(
                        //     "LB ${constraints.maxWidth} x ${constraints.maxHeight}");

                        List<GameItemCubit> items = [];

                        if (state.fixedItems.isEmpty) {
                          for (var item in state.items) {
                            items.add(item.number);
                            if (item.sign != null) {
                              items.add(item.sign!);
                            }
                          }
                          return Stack(children: [
                            ...state.extraItems.map((cubit) {
                              if (cubit is BoardCubit) {
                                return Board(cubit: cubit);
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                            ...items.map((cubit) {
                              if (cubit is NumberCubit) {
                                return Number(
                                    cubit: cubit, key: cubit.state.id);
                              } else if (cubit is SignCubit) {
                                return Sign(cubit: cubit, key: cubit.state.id);
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                            ...state.extraItems.map((cubit) {
                              if (cubit is ShadowNumberCubit) {
                                return ShadowNumber(
                                    cubit: cubit, key: cubit.state.id);
                              } else if (cubit is NumberCubit) {
                                return Number(
                                    cubit: cubit, key: cubit.state.id);
                              } else if (cubit is SignCubit) {
                                return Sign(cubit: cubit, key: cubit.state.id);
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                          ]);
                        } else {
                          for (var item in state.fixedItems) {
                            items.add(item.number);
                            if (item.sign != null) {
                              items.add(item.sign!);
                            }
                          }
                          return Stack(children: [
                            ...state.fixedExtraItems.map((cubit) {
                              if (cubit is BoardCubit) {
                                return Board(cubit: cubit);
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                            ...items.map((cubit) {
                              if (cubit is NumberCubit) {
                                return Number(
                                    cubit: cubit, key: cubit.state.id);
                              } else if (cubit is SignCubit) {
                                return Sign(cubit: cubit, key: cubit.state.id);
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                          ]);
                        }
                      }));
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Spacer(
          flex: 14,
        )
      ],
    );
  }
}
