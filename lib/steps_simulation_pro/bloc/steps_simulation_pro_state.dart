part of 'steps_simulation_pro_bloc.dart';

class StepsSimulationProState {
  final double hUnit;
  final double wUnit;
  final int hUnits;
  final int wUnits;
  final List<SimulationItemCubit> items = [];

  StepsSimulationProState(
      {required this.hUnit,
      required this.wUnit,
      required this.hUnits,
      required this.wUnits});

  void initializeItemsList(List<int> init) {
    var currentTop = (hUnits / 2).ceil() * hUnit;
    var currentLeft = wUnit * 3;
    for (var element in init) {
      if (element > 0) {
        for (int i = 0; i < element; i++) {
          items.add(ArrowCubit(ArrowState(
            color: const Color.fromARGB(255, 68, 157, 114),
            defColor: const Color.fromARGB(255, 68, 157, 114),
            hovColor: const Color.fromARGB(255, 54, 126, 92),
            id: UniqueKey(),
            position: Offset(currentLeft, currentTop),
            size: Size(wUnit, hUnit),
            opacity: 1.0,
          )));
          items.add(FloorCubit(FloorState(
            color: Colors.grey,
            defColor: Colors.grey,
            hovColor: const Color.fromARGB(255, 112, 112, 112),
            id: UniqueKey(),
            position: Offset(currentLeft + wUnit / 2, currentTop),
            size: Size(wUnit * 1.25, hUnit / 7),
            opacity: 1.0,
          ))); //roundness wUnit/15
          // def: Colors.redAccent,
          // hov: const Color.fromARGB(255, 185, 60, 60),
          currentTop -= hUnit;
          currentLeft += wUnit;
        }
      } else {
        for (int i = 0; i > element; i--) {
          items.add(ArrowCubit(ArrowState(
            color: Colors.redAccent,
            defColor: Colors.redAccent,
            hovColor: const Color.fromARGB(255, 185, 60, 60),
            id: UniqueKey(),
            position: Offset(currentLeft, currentTop),
            size: Size(wUnit, hUnit),
            opacity: 1.0,
          )));
          items.add(FloorCubit(FloorState(
            color: Colors.grey,
            defColor: Colors.grey,
            hovColor: const Color.fromARGB(255, 112, 112, 112),
            id: UniqueKey(),
            position: Offset(currentLeft + wUnit / 2, currentTop),
            size: Size(wUnit * 1.25, hUnit / 7),
            opacity: 1.0,
          ))); //roundness wUnit/15

          currentTop += hUnit;
          currentLeft += wUnit;
        }
      }
    }
  }
}
