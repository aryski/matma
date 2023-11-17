import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/prompts/task.dart';

part 'level_state.dart';

class LevelData {
  final String name;
  final List<GameData> gamesData;

  LevelData({required this.name, required this.gamesData});
}

class LevelCubit extends Cubit<LevelState> {
  final LevelData levelData;
  LevelCubit(this.levelData)
      : super(LevelGameState(UniqueKey(),
            startTime: DateTime.now(), gameData: levelData.gamesData.first));

  void nextGame() {
    var currentState = state;
    var gamesData = levelData.gamesData;
    if (currentState is LevelGameState) {
      for (int i = 0; i < gamesData.length; i++) {
        if (gamesData[i] == currentState.gameData && i + 1 < gamesData.length) {
          emit(LevelGameState(UniqueKey(),
              startTime: DateTime.now(), gameData: gamesData[i + 1]));
          return;
        }
      }
    }
    if (currentState is LevelGameState) {
      emit(LevelGameEndState(currentState));
    }
  }

  void refreshGame() {
    var currentState = state;
    var gamesData = levelData.gamesData;
    if (currentState is LevelGameState) {
      for (int i = 0; i < gamesData.length; i++) {
        if (gamesData[i] == currentState.gameData && i < gamesData.length) {
          emit(LevelGameState(UniqueKey(),
              startTime: DateTime.now(), gameData: gamesData[i]));
          return;
        }
      }
    }
  }
}
