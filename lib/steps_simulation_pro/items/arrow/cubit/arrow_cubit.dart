import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:matma/steps_simulation_pro/items/arrow/bloc/arrow_bloc.dart';

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
