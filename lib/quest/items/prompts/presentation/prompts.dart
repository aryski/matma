import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/quest/items/line/presentation/line.dart';
import 'package:matma/quest/items/prompts/cubit/prompts_cubit.dart';
import 'package:matma/quest/items/prompts/cubit/prompts_cubit_state.dart';

class Prompts extends StatelessWidget {
  const Prompts({super.key, required this.cubit});
  final PromptsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: BlocProvider<PromptsCubit>(
          create: (context) => cubit,
          child: BlocBuilder<PromptsCubit, PromptsState>(
              builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: 140,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      ...state.lines.map(
                          (cubit) => Line(cubit: cubit, key: cubit.state.id))
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
