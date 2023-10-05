import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/level_summary.dart';
import 'package:matma/task_simulation/cubit/task_simulation_cubit.dart';
import 'package:matma/task_simulation/cubit/task_simulation_state.dart';

class Tutorial extends StatelessWidget {
  const Tutorial({
    super.key,
    required this.unit,
  });
  final double unit;

  @override
  Widget build(BuildContext context) {
    return TaskSimulator(
      unit: unit,
    );
  }
}

class TaskSimulator extends StatelessWidget {
  const TaskSimulator({super.key, required this.unit});
  final double unit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskSimulationCubit, TaskSimulationState>(
        builder: (context, state) {
      return AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 200,
        ),
        child: state is TaskSimulationStateDisplay
            ? Padding(
                padding: EdgeInsets.only(bottom: 10 * unit),
                child: Center(
                  child: Container(
                    color: defaultBackground,
                    child: AnimatedSwitcher(
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeInQuint,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        state.text,
                        key: UniqueKey(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  const LevelSummary(),
                ],
              ),
      );
    });
  }
}
