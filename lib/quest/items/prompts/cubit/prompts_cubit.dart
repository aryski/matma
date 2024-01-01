import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/quest/items/prompts/cubit/prompts_cubit_state.dart';
import 'package:matma/quest/items/line/cubit/line_cubit.dart';

const double lineHgt = 35.0;
const double lineWdt = 1280;

class PromptsCubit extends Cubit<PromptsState> {
  PromptsCubit() : super(PromptsState(lines: []));

  final howManyLines = 3;

  void addLine(String text) {
    for (int i = 0; i < state.lines.length; i++) {
      var newOpacity = (howManyLines - i - 1) / howManyLines;
      if (newOpacity < 0) newOpacity = 0;
      state.lines[i].setOpacity(newOpacity, milliseconds: 100);
      state.lines[i].updatePosition(const Offset(0, lineHgt));
    }
    var newLine = LineCubit(LineState(
      text: text,
      id: UniqueKey(),
      position: AnimatedProp.zero(value: Offset.zero),
      size: AnimatedProp.zero(value: const Offset(lineWdt, lineHgt)),
      opacity: AnimatedProp.zero(value: 0.0),
    ));
    newLine.setOpacity(1.0, delayInMillis: 40, milliseconds: 400);
    emit(state.copyWith(lines: [newLine, ...state.lines]));
  }
}
