import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'steps_simulation_pro_event.dart';
part 'steps_simulation_pro_state.dart';

class StepsSimulationProBloc extends Bloc<StepsSimulationProEvent, StepsSimulationProState> {
  StepsSimulationProBloc() : super(StepsSimulationProInitial()) {
    on<StepsSimulationProEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
