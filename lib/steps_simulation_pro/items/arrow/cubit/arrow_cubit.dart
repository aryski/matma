import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:matma/steps_simulation_pro/items/arrow/bloc/arrow_bloc.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_simulation_pro/items/simulation_item/cubit/simulation_item_cubit.dart';

class ArrowCubit extends SimulationItemCubit<ArrowState> {
  ArrowCubit(super.initialState);

  void slideIn() {}

  void gemmationClick() {}

  void gemmationClickEnd() {}

  void gemmationReset() {}
}
