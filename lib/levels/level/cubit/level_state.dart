part of 'level_cubit.dart';

@immutable
sealed class LevelState {}

final class LevelGameState extends LevelState {
  final DateTime startTime;
  final GameData gameData;
  final UniqueKey key;

  LevelGameState(this.key, {required this.startTime, required this.gameData});
}

final class LevelGameEndState extends LevelState {
  final LevelGameState currentState;
  LevelGameEndState(this.currentState);
}

abstract class GameData {}

enum StepsGameOps {
  addArrowDown,
  addArrowUp,
  reduceArrows,
  splitJoinArrows,
  addOppositeArrow,
}

class StepsGameData extends GameData {
  final List<StepsGameOps> allowedOps;
  final Task firstTask;
  final List<int> initNumbers;
  final bool withEquation;
  final List<int>? withFixedEquation;
  final List<int>? shadedSteps;
  final bool withHillReduction;
  final bool withValleyReduction;

  StepsGameData(
      {required this.allowedOps,
      required this.firstTask,
      required this.initNumbers,
      this.withEquation = true,
      this.shadedSteps,
      this.withHillReduction = false,
      this.withValleyReduction = false,
      this.withFixedEquation});
}
