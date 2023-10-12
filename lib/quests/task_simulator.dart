import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/quests/cubit/quests_cubit.dart';
import 'package:matma/quests/cubit/quests_state.dart';

class TaskSimulator extends StatelessWidget {
  const TaskSimulator({super.key, required this.unit});
  final double unit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestsCubit, QuestsState>(builder: (context, state) {
      return AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 200,
          ),
          child: state is QuestsStateDisplay
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: 10 * unit * MediaQuery.of(context).size.height),
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
              : const SizedBox.shrink());
    });
  }
}
