part of 'quests_bloc.dart';

final class QuestsState {
  final MiniQuest ongoingMiniQuest;
  final List<TrigEvent> recentTrigEvents;

  QuestsState({required this.ongoingMiniQuest, required this.recentTrigEvents});

  QuestsState copyWith({
    MiniQuest? ongoingMiniQuest,
    List<TrigEvent>? recentTrigEvents,
  }) {
    return QuestsState(
        ongoingMiniQuest: ongoingMiniQuest ?? this.ongoingMiniQuest,
        recentTrigEvents: recentTrigEvents ?? this.recentTrigEvents);
  }
}
