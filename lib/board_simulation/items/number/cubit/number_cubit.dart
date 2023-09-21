import 'package:bloc/bloc.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:meta/meta.dart';

part 'number_state.dart';

class NumberCubit extends SimulationItemCubit<NumberState> {
  NumberCubit(super.initialState);
}
