import 'package:flutter/foundation.dart';

abstract class GameEvent {
  bool isEqual(GameEvent requiredEvent) {
    if (runtimeType == requiredEvent.runtimeType) {
      return true;
    }
    return false;
  }
}

enum GameEvents {
  insertedUp,
  insertedDown,
  merged,
  splited,
  scrolled,
  insertedOpposite,
  equationValue
}

class GameEventInsertedUp extends GameEvent {}

class GameEventInsertedDown extends GameEvent {}

class GameEventMerged extends GameEvent {}

class GameEventSplited extends GameEvent {}

class GameEventScrolled extends GameEvent {}

class GameEventInsertedOpposite extends GameEvent {}

class GameEventEquationValue extends GameEvent {
  final List<int> numbers;

  GameEventEquationValue({required this.numbers});

  @override
  bool isEqual(GameEvent requiredEvent) {
    return super.isEqual(requiredEvent) &&
        (requiredEvent is GameEventEquationValue &&
            listEquals(numbers, requiredEvent.numbers));
  }
}
