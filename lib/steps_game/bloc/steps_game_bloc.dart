import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:matma/steps_game/bloc/bloc_ext/arrows_reductor.dart';
import 'package:matma/steps_game/bloc/bloc_ext/filling_updater.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/steps_game/bloc/bloc_ext/click_handler.dart';
import 'package:matma/steps_game/bloc/bloc_ext/list_initializer.dart';
import 'package:matma/steps_game/bloc/bloc_ext/scroll_handler.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/filling/cubit/filling_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/prompts/cubit/quests_cubit.dart';
import 'package:stream_transform/stream_transform.dart';

part 'steps_game_event.dart';
part 'steps_game_state.dart';

UniqueKey? hoverKepper;

class GameSize {
  final double hUnits;
  final double wUnits;

  double get hUnit => 1 / hUnits;
  double get wUnit => 1 / wUnits;

  double get arrowH => hUnit;
  double get arrowClickedHgt => arrowH / 2;
  double get arrowReleasedHgt => arrowH * 2;
  double get arrowW => wUnit;

  double get radius => 1 / 15 * wUnit;

  double get floorH => arrowH / 5;
  double get floorWMini => wUnit * 0.25;
  double get floorW => wUnit * 1.25;
  double get floorWExt => wUnit + floorW;

  const GameSize({required this.hUnits, required this.wUnits});
}

class StepsGameBloc extends Bloc<StepsGameEvent, StepsGameState> {
  final List<StepsGameOps> allowedOps;
  final EquationBloc board;
  final GameSize gs;
  final List<UniqueKey> lockedIds = [];
  final QuestsCubit taskCubit;
  DateTime downClick = DateTime.timestamp();
  @override
  StepsGameBloc(this.gs, this.board, this.taskCubit, this.allowedOps)
      : super(StepsGameState(gs: gs, numbers: [], unorderedItems: {})) {
    state.numbers.addAll(initializeSimulationItems());
    generateFillings();

    on<StepsGameEventScroll>((event, emit) async {
      await handleScroll(state, event, gs, emit);
    }, transformer: eventScrollTransformer);

    on<StepsGameEventClick>((event, emit) async {
      await handleClick(event, emit);
    }, transformer: sequential());

    on<StepsGameEventPopFilling>((event, emit) async {
      if (allowedOps.contains(StepsGameOps.reducingArrowsCascadedly)) {
        var item = state.getItem(event.id);
        if (item is FillingCubit) {
          var number = state.getNumberFromItem(item);
          if (number != null && number.steps.isNotEmpty) {
            var floor = number.steps.last.floor;
            await handleReduction(
                floor, -floor.state.size.value.dx, state, emit);
          }
        }
      }
    }, transformer: sequential());
  }

  Stream<StepsGameEventScroll> eventScrollTransformer(
      Stream<StepsGameEventScroll> events,
      EventMapper<StepsGameEventScroll> mapper) {
    return sequential<StepsGameEventScroll>()(
        events.debounceBuffer(const Duration(milliseconds: 50)).map(
          (bufferedEvents) {
            UniqueKey scroll = UniqueKey();
            double dySum = 0;
            for (var event in bufferedEvents) {
              scroll = event.id;
              dySum += event.dy;
            }
            return StepsGameEventScroll(scroll, dySum);
          },
        ),
        mapper);
  }

  @override
  void onChange(Change<StepsGameState> change) {
    taskCubit.equationValue(state.numbers.map((e) => e.number).toList());
    super.onChange(change);
  }
}
