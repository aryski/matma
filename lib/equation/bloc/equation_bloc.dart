import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/equation/constants.dart' as constants;
import 'package:matma/equation/items/value/cubit/value_cubit.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/equation/items/board/cubit/board_cubit.dart';
import 'package:matma/equation/items/shadow_number/cubit/shadow_number_cubit.dart';

part 'equation_event.dart';
part 'equation_state.dart';
part 'bloc_ext/common/items_generator.dart';
part 'bloc_ext/insertor.dart';
part 'bloc_ext/reducer.dart';
part 'bloc_ext/splitter.dart';
part 'bloc_ext/joiner.dart';
part 'bloc_ext/incrementer.dart';
part 'bloc_ext/common/remover.dart';
part 'bloc_ext/resetter.dart';
part 'bloc_ext/common/resizer.dart';
part 'bloc_ext/common/shadow_numbers_generator.dart';

class EquationBloc extends Bloc<EquationEvent, EquationState> {
  final EquationState init;
  final List<int>? targetValues; //if not null then Equation is fixed

  EquationBloc(
      {required this.init,
      required List<int> initNumbers,
      this.targetValues,
      required int wUnits})
      : super(Resetter.generateState(initNumbers, targetValues)) {
    on<EquationEventIncreaseNumber>((event, emit) {
      var item = state.getItem(event.ind);
      if (item != null) {
        increment(item);
        emit(state.copyWith());
      }
    });
    on<EquationEventJoinNumbers>((event, emit) {
      var lItem = state.getItem(event.lInd);
      var rItem = state.getItem(event.rInd);
      if (lItem != null && rItem != null) {
        join(lItem, rItem);
        emit(state.copyWith());
      }
    });
    on<EquationEventInsertNumber>(
      (event, emit) {
        if (state.items.isNotEmpty) {
          insertNumberAfterItem(event.number, state.items.last);
          emit(state.copyWith());
        }
      },
    );
    on<EquationEventSplitNumber>(
      (event, emit) {
        var item = state.getItem(event.ind);
        if (item != null) {
          split(item, event);
        }
        emit(state.copyWith());
      },
    );
    on<EquationEventNumbersReduction>((event, emit) {
      var lItem = state.getItem(event.lInd);
      var rItem = state.getItem(event.rInd);
      if (lItem != null && rItem != null) {
        reduce(lItem, rItem);
        emit(state.copyWith());
      }
    });
  }
}
