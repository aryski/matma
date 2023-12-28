import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/quest/items/mini_quest.dart';

part 'level_state.dart';

class LevelData {
  final int ind;
  final String name;
  final IconData icon;
  final List<GameData> gamesData;

  LevelData(
      {required this.icon,
      required this.ind,
      required this.name,
      required this.gamesData});
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
        if (gamesData[i] == currentState.gameData) {
          emit(LevelGameState(UniqueKey(),
              startTime: DateTime.now(), gameData: gamesData[i]));
          return;
        }
      }
    }
  }
}
