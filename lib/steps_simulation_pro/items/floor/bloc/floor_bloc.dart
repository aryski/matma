// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:matma/steps_simulation_pro/items/simulation_item/cubit/simulation_item_state.dart';
// import 'package:meta/meta.dart';

// part 'floor_event.dart';
// part 'floor_state.dart';

// class FloorBloc extends Bloc<FloorEvent, FloorState> {
//   final FloorState init;
//   FloorBloc(this.init) : super(init) {
//     on<FloorEventHoverStart>((event, emit) {
//       state.color = state.hovColor;
//       emit(state.copy());
//     });
//     on<FloorEventHoverEnd>((event, emit) {
//       state.color = state.defColor;
//       emit(state.copy());
//     });
//   }
// }
