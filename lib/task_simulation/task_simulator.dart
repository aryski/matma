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

// class SubtaskDisplayer extends StatefulWidget {
//   const SubtaskDisplayer({super.key, required this.task});
//   final Subtask task;

//   @override
//   State<SubtaskDisplayer> createState() => _SubtaskDisplayerState();
// }

// class _SubtaskDisplayerState extends State<SubtaskDisplayer> {
//   late String current = widget.task.text.first.text;
//   @override
//   void initState() {
//     Duration dur = Duration.zero;
//     for (int i = 0; i < widget.task.text.length; i++) {
//       Future.delayed(dur, () {
//         updateCurrent(widget.task.text[i].text);
//       });
//       if (widget.task.text[i].time != null) {
//         dur += widget.task.text[i].time!;
//       }
//     }
//     super.initState();
//   }

//   void updateCurrent(String text) {
//     if (mounted) {
//       setState(() {
//         current = text;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//         switchInCurve: Curves.easeIn,
//         switchOutCurve: Curves.easeInQuint,
//         duration: const Duration(milliseconds: 500),
//         child: Center(
//           key: UniqueKey(),
//           child: Text(
//             current,
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
//           ),
//         ));
//   }
// }
