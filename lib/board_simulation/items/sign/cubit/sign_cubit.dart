import 'package:bloc/bloc.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';

part 'sign_state.dart';

class SignCubit extends SimulationItemCubit<SignState> {
  SignCubit(super.initialState);
}
