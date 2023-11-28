import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/prompts/cubit/prompts_cubit.dart';
import 'package:matma/prompts/cubit/prompts_state.dart';
import 'package:matma/prompts/items/line/presentation/line.dart';

class TaskSimulator extends StatelessWidget {
  const TaskSimulator({super.key, required this.unit});
  final double unit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromptsCubit, PromptsState>(builder: (context, state) {
      return Stack(
        children: [...state.lines.map((cubit) => Line(cubit: cubit))],
      );
    });
  }
}
