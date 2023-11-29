import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_game/items/filling/cubit/filling_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/prompts/cubit/prompts_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:matma/steps_game/bloc/constants.dart' as constants;

part 'steps_game_event.dart';
part 'steps_game_state.dart';
part 'bloc_ext/arrow_insertor.dart';
part 'bloc_ext/arrows_reductor.dart';
part 'bloc_ext/click_handler.dart';
part 'bloc_ext/filling_updater.dart';
part 'bloc_ext/items_generator.dart';
part 'bloc_ext/list_initializer.dart';
part 'bloc_ext/number_joiner.dart';
part 'bloc_ext/number_splitter.dart';
part 'bloc_ext/opposite_arrow_insertor.dart';
part 'bloc_ext/scroll_handler.dart';

UniqueKey? hoverKepper;

class StepsGameBloc extends Bloc<StepsGameEvent, StepsGameState> {
  final List<StepsGameOps> allowedOps;
  final EquationBloc board;
  final List<UniqueKey> lockedIds = [];
  final PromptsCubit promptCubit;
  final int hUnits;
  final int wUnits;
  DateTime downClick = DateTime.timestamp();
  @override
  StepsGameBloc(
      this.board, this.promptCubit, this.allowedOps, this.wUnits, this.hUnits)
      : super(StepsGameState(numbers: [], unorderedItems: {})) {
    state.numbers.addAll(initializeSimulationItems(wUnits, hUnits));
    generateFillings();

    on<StepsGameEventScroll>((event, emit) async {
      await handleScroll(state, event, emit);
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
    promptCubit.equationValue(state.numbers.map((e) => e.number).toList());
    super.onChange(change);
  }
}
