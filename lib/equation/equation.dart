import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/equation/items/items.dart';

class Equation extends StatelessWidget {
  const Equation({super.key});
  final double topPadding = 224 * 1 / 4;
  final double height = 224 * 3 / 4;
  final double width = 1920;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Center(
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: BlocBuilder<EquationBloc, EquationState>(
                    builder: (context, state) {
                  return LayoutBuilder(
                    builder: ((context, constraints) {
                      List<GameItemCubit> items = [];
                      for (var item in state.fixedItems.isEmpty
                          ? state.items
                          : state.fixedItems) {
                        items.add(item.value);
                        if (item.sign != null) {
                          items.add(item.sign!);
                        }
                      }
                      return state.fixedItems.isEmpty
                          ? DefaultEquation(items: items, state: state)
                          : FixedEquation(items: items, state: state);
                    }),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FixedEquation extends StatelessWidget {
  const FixedEquation({
    super.key,
    required this.items,
    required this.state,
  });

  final List<GameItemCubit<GameItemState>> items;
  final EquationState state;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ...state.fixedExtraItems.map((cubit) {
        if (cubit is BoardCubit) {
          return Board(cubit: cubit);
        } else {
          return const SizedBox.shrink();
        }
      }),
      ...items.map((cubit) {
        if (cubit is ValueCubit) {
          return Value(cubit: cubit, key: cubit.state.id);
        } else if (cubit is SignCubit) {
          return Sign(cubit: cubit, key: cubit.state.id);
        } else {
          return const SizedBox.shrink();
        }
      }),
    ]);
  }
}

class DefaultEquation extends StatelessWidget {
  const DefaultEquation({
    super.key,
    required this.items,
    required this.state,
  });
  final EquationState state;

  final List<GameItemCubit<GameItemState>> items;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ...state.extraItems.map((cubit) {
        if (cubit is BoardCubit) {
          return Board(cubit: cubit);
        } else {
          return const SizedBox.shrink();
        }
      }),
      ...items.map((cubit) {
        if (cubit is ValueCubit) {
          return Value(cubit: cubit, key: cubit.state.id);
        } else if (cubit is SignCubit) {
          return Sign(cubit: cubit, key: cubit.state.id);
        } else {
          return const SizedBox.shrink();
        }
      }),
      ...state.extraItems.map((cubit) {
        if (cubit is ShadowNumberCubit) {
          return ShadowNumber(cubit: cubit, key: cubit.state.id);
        } else if (cubit is ValueCubit) {
          return Value(cubit: cubit, key: cubit.state.id);
        } else if (cubit is SignCubit) {
          return Sign(cubit: cubit, key: cubit.state.id);
        } else {
          return const SizedBox.shrink();
        }
      }),
    ]);
  }
}
