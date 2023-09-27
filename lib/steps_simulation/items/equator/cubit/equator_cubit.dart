import 'package:bloc/bloc.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:meta/meta.dart';

import 'package:flutter/material.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_state.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

part 'equator_state.dart';

class EquatorCubit extends SimulationItemCubit<EquatorState> {
  EquatorCubit(super.initialState);
}
