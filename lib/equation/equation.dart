import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/equation/items/items.dart';

class Equation extends StatelessWidget {
  const Equation({super.key, required this.unit});
  final double unit;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child:
          BlocBuilder<EquationBloc, EquationState>(builder: (context, state) {
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
                return Number(cubit: cubit, key: cubit.state.id);
              } else if (cubit is SignCubit) {
                return Sign(cubit: cubit, key: cubit.state.id);
              } else {
                return const SizedBox.shrink();
              }
            }),
            ...state.extraItems.map((cubit) {
              if (cubit is ShadowNumberCubit) {
                return ShadowNumber(cubit: cubit, key: cubit.state.id);
              } else if (cubit is NumberCubit) {
                return Number(cubit: cubit, key: cubit.state.id);
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
                return Number(cubit: cubit, key: cubit.state.id);
              } else if (cubit is SignCubit) {
                return Sign(cubit: cubit, key: cubit.state.id);
              } else {
                return const SizedBox.shrink();
              }
            }),
          ]);
        }
      }),
    );
  }
}
