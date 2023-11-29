part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension FillingUpdater on StepsGameBloc {
  void animateNeigboringFillings(int ind, bool animateIn) {
    var number = state.numbers[ind];
    var filling = number.filling;
    StepsGameNumberState? previousFilling =
        ind - 1 >= 0 ? state.numbers[ind - 1] : null;
    if (animateIn) {
      filling?.animateToDef();
      previousFilling?.filling?.animateToDef();
    } else {
      filling?.animateToRight();
      previousFilling?.filling?.animateToLeft();
    }
  }

  void animateLeftFilling(GameItemCubit item, bool animateIn) {
    var ind = state.getNumberIndexFromItem(item);
    if (ind != null) {
      StepsGameNumberState? previousFilling =
          ind - 1 >= 0 ? state.numbers[ind - 1] : null;
      if (animateIn) {
        previousFilling?.filling?.animateToDef();
      } else {
        previousFilling?.filling?.animateToLeft();
      }
    }
  }

  void animateRightFilling(GameItemCubit item, bool animateIn) {
    var ind = state.getNumberIndexFromItem(item);
    if (ind != null) {
      StepsGameNumberState? nextFilling =
          ind + 1 < state.numbers.length ? state.numbers[ind + 1] : null;
      if (animateIn) {
        nextFilling?.filling?.animateToDef();
      } else {
        nextFilling?.filling?.animateToRight();
      }
    }
  }

  void onArrowClickDown(GameItemCubit item, double delta) {
    var ind = state.getNumberIndexFromItem(item);
    if (ind != null) {
      animateNeigboringFillings(ind, false);
    }
  }

  void onArrowClickUp(GameItemCubit item, double delta) {
    var ind = state.getNumberIndexFromItem(item);
    if (ind != null) {
      animateNeigboringFillings(ind, true);
    }
  }

  void generateFillings() {
    if (allowedOps.contains(StepsGameOps.reducingArrowsCascadedly)) {
      for (int i = 0; i < state.numbers.length; i++) {
        updateFilling(state, i);
      }
    }
  }

//checks in item's ind and next ind
  void updateFilling(StepsGameState state, int numberInd) {
    int ind = numberInd;
    if (0 <= ind && ind + 1 < state.numbers.length) {
      if (state.numbers[ind].number == -state.numbers[ind + 1].number) {
        if (state.numbers[ind].steps.isNotEmpty) {
          var floorState = state.numbers[ind].steps.last.floor.state;
          var n = state.numbers[ind].number;
          if (state.numbers[ind].filling == null) {
            FillingCubit filling = generateFilling(n, floorState);
            filling.setOpacity(1.0, delayInMillis: 200);
            state.numbers[ind].setFilling(filling);
          }
        }
      } else {
        removeFilling(state, ind);
      }
    }
  }
}

bool removeFilling(StepsGameState state, int ind) {
  var filling = state.numbers[ind].filling;
  if (filling != null) {
    state.unorderedItems.addAll({filling.state.id: filling});
    filling.setOpacity(0);
    state.numbers[ind].filling = null;
    return true;
  }
  return false;
}

FillingCubit generateFilling(int n, FloorState floorState) {
  var filling = FillingCubit(
    FillingState(
        stepHgt: constants.arrowH,
        animProgress: 0,
        steps: n,
        stepWdt: constants.arrowW,
        id: UniqueKey(),
        position: AnimatedProp.zero(
            value: n > 0
                ? floorState.position.value +
                    Offset(-(n.abs() - 1) * constants.arrowW, constants.floorH)
                : floorState.position.value +
                    Offset(
                        -(n.abs() - 1) * constants.arrowW,
                        constants.floorH -
                            n.abs() * constants.arrowH -
                            constants.floorH)),
        size: AnimatedProp.zero(
            value: Offset(
                (n.abs() - 1) * 2 * constants.arrowW +
                    floorState.size.value.dx -
                    constants.arrowW / 4,
                n.abs() * constants.arrowH)),
        isHovered: false,
        opacity: AnimatedProp.zero(value: 0.0),
        radius: constants.radius),
  );
  return filling;
}
