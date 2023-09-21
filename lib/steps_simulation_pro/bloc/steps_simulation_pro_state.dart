part of 'steps_simulation_pro_bloc.dart';

class StepsSimulationProState {
  final SimulationSize simSize;
  final List<SimulationItemCubit> items;

  StepsSimulationProState({required this.simSize, required this.items});

  void moveAllSince(SimulationItemCubit item, Offset offset) {
    var ind = items.indexOf(item);
    for (int i = ind + 1; i < items.length; i++) {
      SimulationItemCubit cubit = items[i];
      cubit.updatePosition(offset);
    }
  }

  void moveAllSinceIncluded(SimulationItemCubit item, Offset offset) {
    var ind = items.indexOf(item);
    for (int i = ind; i < items.length; i++) {
      SimulationItemCubit cubit = items[i];
      cubit.updatePosition(offset);
    }
  }

  StepsSimulationProState copy() {
    return StepsSimulationProState(simSize: simSize, items: [...items]);
  }

  SimulationItemCubit getItem(UniqueKey id) {
    return items.firstWhere((element) => element.state.id == id);
  }

  int getIndex(UniqueKey id) {
    return items.indexWhere((element) => element.state.id == id);
  }
}
