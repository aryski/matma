part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension FillingUpdater on StepsGameBloc {
  void animateNeigboringFillings(int ind, bool animateIn, int millis) {
    var number = state.numbers[ind];
    var filling = number.filling;
    StepsGameNumberState? previousFilling =
        ind - 1 >= 0 ? state.numbers[ind - 1] : null;
    if (animateIn) {
      filling?.animateFoldNone(millis: millis);
      previousFilling?.filling?.animateFoldNone(millis: millis);
    } else {
      filling?.animateFoldRight(millis: millis);
      previousFilling?.filling?.animateFoldLeft(millis: millis);
    }
  }

  void animateLeftFilling(GameItemCubit item, bool animateIn, int millis) {
    var ind = state.getNumberIndexFromItem(item);
    if (ind != null) {
      StepsGameNumberState? previousFilling =
          ind - 1 >= 0 ? state.numbers[ind - 1] : null;
      if (animateIn) {
        previousFilling?.filling?.animateFoldNone(millis: millis);
      } else {
        previousFilling?.filling?.animateFoldLeft(millis: millis);
      }
    }
  }

  void animateRightFilling(GameItemCubit item, bool animateIn, int millis) {
    var ind = state.getNumberIndexFromItem(item);
    if (ind != null) {
      StepsGameNumberState? nextFilling =
          ind + 1 < state.numbers.length ? state.numbers[ind + 1] : null;
      if (animateIn) {
        nextFilling?.filling?.animateFoldNone(millis: millis);
      } else {
        nextFilling?.filling?.animateFoldRight(millis: millis);
      }
    }
  }

  void onArrowClickDown(GameItemCubit item, double delta, int millis) {
    var ind = state.getNumberIndexFromItem(item);
    if (ind != null) {
      animateNeigboringFillings(ind, false, millis);
    }
  }

  void onArrowClickUp(GameItemCubit item, double delta, int millis) {
    var ind = state.getNumberIndexFromItem(item);
    if (ind != null) {
      animateNeigboringFillings(ind, true, millis);
    }
  }

  void generateFillings(int millis) {
    for (int i = 0; i < state.numbers.length; i++) {
      updateFilling(state, i, millis);
    }
  }

//checks in item's ind and next ind
  void updateFilling(StepsGameState state, int numberInd, int millis) {
    int ind = numberInd;
    if (0 <= ind && ind + 1 < state.numbers.length) {
      if (state.numbers[ind].number == -state.numbers[ind + 1].number) {
        if (state.numbers[ind].steps.isNotEmpty) {
          var floorState = state.numbers[ind].steps.last.floor.state;
          var n = state.numbers[ind].number;
          if (state.numbers[ind].filling == null) {
            FillingCubit filling = generateFilling(n, floorState);
            filling.setOpacity(1.0, delayInMillis: 200, millis: millis);
            state.numbers[ind].setFilling(filling);
          }
        }
      } else {
        removeFilling(state, ind, millis);
      }
    }
  }
}

bool removeFilling(StepsGameState state, int ind, int millis) {
  var filling = state.numbers[ind].filling;
  if (filling != null) {
    state.unorderedItems.addAll({filling.state.id: filling});
    filling.setOpacity(0, millis: millis);
    state.numbers[ind].filling = null;
    return true;
  }
  return false;
}

FillingCubit generateFilling(int n, FloorState floorState) {
  var filling = FillingCubit(
    FillingState(
      stepHgt: constants.arrowH,
      fold: AnimatedProp.zero(value: FillingFold.none),
      steps: n,
      stepWdt: constants.floorW,
      id: UniqueKey(),
      position: AnimatedProp.zero(
          value: floorState.position.value +
              Offset(-(n.abs() - 1) * constants.floorW,
                  n > 0 ? constants.floorH : -n.abs() * constants.arrowH)),
      size: AnimatedProp.zero(
          value: Offset(
              (n.abs() - 1) * 2 * constants.floorW + floorState.size.value.dx,
              n.abs() * constants.arrowH)),
      isHovered: false,
      opacity: AnimatedProp.zero(value: 0.0),
    ),
  );
  return filling;
}
