import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/task_simulation/cubit/task_simulation_cubit.dart';

class Tutorial extends StatelessWidget {
  const Tutorial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TaskSimulator();
  }
}

class TaskSimulator extends StatelessWidget {
  const TaskSimulator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskSimulationCubit, String>(builder: (context, state) {
      return Column(
        children: [
          AnimatedSwitcher(
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeInQuint,
            duration: const Duration(milliseconds: 500),
            child: Text(
              state,
              key: UniqueKey(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
          )
        ],
      );
    });
  }
}
