import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation_native/items/simulation_item_state.dart';
import 'package:matma/stairs_simulation_native/simulation_item_state.dart';
import 'package:bloc/bloc.dart';

part 'arrow_event.dart';
part 'arrow_state.dart';

class ArrowBloc extends Bloc<ArrowEvent, ArrowState> {
  final ArrowState init;

  ArrowBloc(this.init) : super(init) {
    on<ArrowEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
