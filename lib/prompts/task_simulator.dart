import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/prompts/cubit/prompts_cubit.dart';
import 'package:matma/prompts/cubit/prompts_state.dart';
import 'package:matma/prompts/items/line/presentation/line.dart';

class Prompts extends StatelessWidget {
  const Prompts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child:
            BlocBuilder<PromptsCubit, PromptsState>(builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                height: 224,
                child: Center(
                  child: Stack(
                    children: [
                      ...state.lines
                          .map((cubit) => Center(child: Line(cubit: cubit)))
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
