part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension MinMaxLevelSince on StepsGameState {
  int? minimumLevelSince(StepsGameNumberState number) {
    return _minmaxLevelSince(number, (a, b) => a > b);
  }

  int? maxiumumLevelSince(StepsGameNumberState number) {
    return _minmaxLevelSince(number, (a, b) => a < b);
  }

  int? _minmaxLevelSince(
      StepsGameNumberState numberItem, bool Function(int, int) cmp) {
    int result = 0;
    int value = 0;
    bool reset = false;
    for (var number in numbers) {
      if (number == numberItem) {
        result = 0;
        reset = true;
      }
      value += number.number;
      if (cmp(result, value)) {
        result = value;
      }
    }
    if (reset) {
      return result;
    }
    return null;
  }
}
