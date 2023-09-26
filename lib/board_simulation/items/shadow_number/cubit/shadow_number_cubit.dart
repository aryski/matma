import 'package:bloc/bloc.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:meta/meta.dart';

part 'shadow_number_state.dart';

class ShadowNumberCubit extends SimulationItemCubit<ShadowNumberState> {
  ShadowNumberCubit(super.initialState);
}
