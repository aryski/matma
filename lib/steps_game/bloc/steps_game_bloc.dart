import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';
import 'package:matma/steps_game/bloc/bloc_ext/common/delta_size_guardian.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_game/items/filling/cubit/filling_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:matma/steps_game/bloc/constants.dart' as constants;

part 'bloc_ext/common/floor_resizer.dart';
part 'steps_game_event.dart';
part 'steps_game_state.dart';
part 'state_ext/min_max_level.dart';
part 'state_ext/steps_ops.dart';
part 'state_ext/items_ops.dart';
part 'bloc_ext/common/items_updater.dart';
part 'bloc_ext/common/arrow_insertor.dart';
part 'bloc_ext/scroll_ops_handlers/reduction_handler.dart';
part 'bloc_ext/click_arrow_handler.dart';
part 'bloc_ext/click_filling_handler.dart';
part 'bloc_ext/click_floor_handler.dart';
part 'bloc_ext/common/filling_updater.dart';
part 'bloc_ext/common/items_generator.dart';
part 'bloc_ext/list_initializer.dart';
part 'bloc_ext/scroll_ops_handlers/join_handler.dart';
part 'bloc_ext/scroll_ops_handlers/split_handler.dart';
part 'bloc_ext/scroll_floor_handler.dart';

UniqueKey? hoverKepper;

class StepsGameBloc extends Bloc<StepsTrigEvent, StepsGameState> {
  final List<StepsGameOps> allowedOps;
  final EquationBloc board;
  final QuestsBloc questsBloc;
  @override
  StepsGameBloc(this.board, this.questsBloc, this.allowedOps)
      : super(StepsGameState(
            showFilling:
                allowedOps.contains(StepsGameOps.reducingArrowsCascadedly),
            numbers: [],
            unorderedItems: {})) {
    initializeSimulationItems();

    on<StepsTrigEventScrollFloor>((event, emit) async {
      await handleScrollFloor(state, event, emit);
    }, transformer: eventScrollTransformer);

    on<StepsTrigEventClickArrow>((event, emit) async {
      await handleClickArrow(event, emit, 200);
    }, transformer: sequential());

    on<StepsTrigEventClickFilling>((event, emit) async {
      await handleClickFilling(event, emit);
    }, transformer: sequential());

    on<StepsTrigEventClickFloor>((event, emit) async {
      await handleClickFloor(event, emit);
    }, transformer: sequential());
  }

  Stream<StepsTrigEventScrollFloor> eventScrollTransformer(
      Stream<StepsTrigEventScrollFloor> events,
      EventMapper<StepsTrigEventScrollFloor> mapper) {
    return sequential<StepsTrigEventScrollFloor>()(
        events.debounceBuffer(const Duration(milliseconds: 50)).map(
          (bufferedEvents) {
            UniqueKey scroll = UniqueKey();
            double dySum = 0;
            for (var event in bufferedEvents) {
              scroll = event.id;
              dySum += event.dy;
            }
            return StepsTrigEventScrollFloor(scroll, dySum);
          },
        ),
        mapper);
  }

  @override
  void onChange(Change<StepsGameState> change) {
    questsBloc.add(TrigEventEquationValue(
        numbers: state.numbers.map((e) => e.number).toList()));
    super.onChange(change);
  }
}
