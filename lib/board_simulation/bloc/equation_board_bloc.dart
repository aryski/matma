import 'package:bloc/bloc.dart';
import 'package:matma/board_simulation/cubit/equation_board_cubit.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:meta/meta.dart';

part 'equation_board_event.dart';
part 'equation_board_state.dart';

class EquationBoardBloc extends Bloc<EquationBoardEvent, EquationBoardState> {
  final EquationBoardState init;
  final SimulationSize simSize;
  EquationBoardBloc(this.init, this.simSize) : super(init) {
    on<EquationBoardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
