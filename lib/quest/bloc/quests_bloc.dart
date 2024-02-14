import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/quest/items/prompts/cubit/prompts_cubit.dart';
import 'package:matma/quest/items/mini_quest.dart';
import 'package:flutter/foundation.dart';

part 'quests_event.dart';
part 'quests_state.dart';

class QuestsBloc extends Bloc<QuestsEvent, QuestsState> {
  final LevelCubit parent;
  final PromptsCubit promptsCubit = PromptsCubit();
  int schedulePromptsCounter = 0;

  QuestsBloc(this.parent, MiniQuest firstQuest)
      : super(QuestsState(ongoingMiniQuest: firstQuest, recentTrigEvents: [])) {
    schedulePrompts(firstQuest.prompts, promptsCubit, schedulePromptsCounter);
    on<TrigEvent>((event, emit) {
      var newRecent = [...state.recentTrigEvents, event];
      var choice = state.ongoingMiniQuest.returnTriggeredChoice(newRecent);
      if (choice != null) {
        emit(QuestsState(
            ongoingMiniQuest: choice.miniQuest, recentTrigEvents: []));
        schedulePrompts(state.ongoingMiniQuest.prompts, promptsCubit,
            schedulePromptsCounter);
      } else {
        emit(state.copyWith(recentTrigEvents: newRecent));
      }
    });
  }

  void schedulePrompts(List<Prompt> prompts, PromptsCubit cubit, int id) async {
    schedulePromptsCounter += 1;
    for (var prompt in prompts) {
      if (cubit.isClosed) break;
      if (prompt is NextPrompt) {
        if (id + 1 != schedulePromptsCounter) {
          break;
        }
        cubit.addLine(prompt.text);
        await Future.delayed(prompt.millis);
      } else if (prompt is EndPrompt) {
        parent.nextGame();
      }
    }
  }
}
