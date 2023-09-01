import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/stairs_simulation_native/items/floor/bloc/floor_bloc.dart';

class FloorCubit extends Cubit<FloorState> {
  FloorCubit(super.initialState);

  void updatePosition(Offset delta) {}

  void hoverStart() {}

  void hoverEnd() {}

  void updateSize(Size delta) {}
}
