import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:matma/stairs_simulation_native/items/arrow/cubit/arrow_state.dart';

class ArrowCubit extends Cubit<ArrowState> {
  ArrowCubit(super.initialState);

  void slideIn() {}

  void updatePosition(Offset delta) {}

  void hoverStart() {}

  void hoverEnd() {}

  void gemmationClick() {}

  void gemmationClickEnd() {}

  void gemmationReset() {}
}
