part of 'stairs_simulation_bloc.dart';

enum Direction { up, down }

abstract class SimulationItem {
  UniqueKey id;
  Offset position;
  double width;
  double height;
  double opacity;
  Direction orientation;

  Duration positionDuration;
  SimulationItem(this.id, this.position, this.width, this.height, this.opacity,
      this.orientation, this.positionDuration);
}

class FlatSimulationItem extends SimulationItem {
  double radius;
  FlatSimulationItem(super.id, super.position, super.width, super.height,
      super.opacity, super.orientation, super.positionDuration, this.radius);
}

class StepSimulationItem extends SimulationItem {
  double gemmationProgress;
  StepSimulationItem(
      super.id,
      super.position,
      super.width,
      super.height,
      super.opacity,
      super.orientation,
      super.positionDuration,
      this.gemmationProgress);
}

UniqueKey? hoverKepper;

class Hover {
  int id;
  bool isArrow;
  Hover(this.id, this.isArrow);
}

Duration defaultDuration = const Duration(milliseconds: 200);

class StepsSimulationState {
  final double hUnit;
  final double wUnit;
  final int hUnits;
  final int wUnits;
  Hover? currentHover;
  List<SimulationItem> items = [];

  StepsSimulationState(this.hUnit, this.wUnit, this.hUnits, this.wUnits);

  void initializeStairList(List<int> init) {
    var currentTop = (hUnits / 2).ceil() * hUnit;
    var currentLeft = wUnit * 3;
    for (var element in init) {
      if (element > 0) {
        for (int i = 0; i < element; i++) {
          items.add(
            StepSimulationItem(
              UniqueKey(),
              Offset(currentLeft, currentTop),
              wUnit,
              hUnit,
              1,
              Direction.up,
              defaultDuration,
              1,
            ),
          );

          items.add(
            FlatSimulationItem(
                UniqueKey(),
                Offset(
                  currentLeft + wUnit / 2,
                  currentTop,
                ),
                wUnit * 1.25,
                hUnit / 7,
                1,
                Direction.up,
                defaultDuration,
                wUnit / 15),
          );
          currentTop -= hUnit;
          currentLeft += wUnit;
        }
      } else {
        for (int i = 0; i > element; i--) {
          items.add(
            StepSimulationItem(
                UniqueKey(),
                Offset(currentLeft, currentTop + hUnit + hUnit / 7),
                wUnit,
                hUnit,
                1,
                Direction.down,
                defaultDuration,
                1),
          );

          items.add(
            FlatSimulationItem(
                UniqueKey(),
                Offset(currentLeft + wUnit / 2, currentTop + hUnit + hUnit),
                wUnit * 1.25,
                hUnit / 7,
                1,
                Direction.down,
                defaultDuration,
                wUnit / 15),
          );
          currentTop += hUnit;
          currentLeft += wUnit;
        }
      }
    }
  }

  @override
  String toString() {
    List<int> result = [];
    int number = 0;
    for (int i = 0; i < items.length; i++) {
      if (items[i] is StepSimulationItem) {
        if (items[i].orientation == Direction.up) {
          if (number < 0) {
            result.add(number);
            number = 0;
          }
          number++;
        } else if (items[i].orientation == Direction.down) {
          if (number > 0) {
            result.add(number);
            number = 0;
          }
          number--;
        }
      } else if (items[i] is FlatSimulationItem) {
        if (items[i].width > 1.5 * wUnit || i + 1 == items.length) {
          result.add(number);
          number = 0;
        }
      }
    }
    return result.toString();
  }

  void updateHover(Hover? hover) {
    currentHover = hover;
  }

  StepsSimulationState copy() {
    var xd = StepsSimulationState(hUnit, wUnit, hUnits, wUnits);
    xd.items = items;
    return xd;
  }

  void scrollId(UniqueKey id, double delta) {
    var originalWidth = wUnit * 1.25;
    var minimalWidth = wUnit * 0.7;
    var ind = items.indexWhere((element) => element.id == id);
    if (ind != -1 && items[ind] is FlatSimulationItem) {
      var possibleDelta = delta / 20;
      var prevWidth = items[ind].width;
      var doesBoom = false;
      if (items[ind].width + possibleDelta < minimalWidth) {
        items[ind].width = minimalWidth;
        doesBoom = true;
        //ELIMINATE SET
      } else {
        items[ind].width += possibleDelta;
        double opacity =
            (items[ind].width - minimalWidth) / (originalWidth - minimalWidth);
        if (opacity > 1) {
          opacity = 1;
        }
        //TODO opacity
        if (ind - 1 >= 0 &&
            ind + 1 < items.length &&
            items[ind - 1].orientation != items[ind + 1].orientation) {
          items[ind].opacity = opacity;
          items[ind - 1].opacity = opacity;
          items[ind + 1].opacity = opacity;
        }
      }
      possibleDelta = items[ind].width - prevWidth;

      for (int i = ind + 1; i < items.length; i++) {
        items[i].position += Offset(possibleDelta, 0);
      }
      if (doesBoom) {
        boom(ind, minimalWidth - 0.5 * wUnit);
      }
    }
  }

  void boom(int ind, double adj) {
    if (ind - 1 >= 0 &&
        ind + 2 < items.length &&
        items[ind - 1].orientation != items[ind + 1].orientation) {
      items.removeAt(ind - 1);
      items.removeAt(ind - 1);
      items.removeAt(ind - 1);
      if (ind - 2 >= 0) {
        print("EXTRA WIDTH");
        print(items[ind - 1].width);
        items[ind - 2].width += items[ind - 1].width + adj;
      }
      items.removeAt(ind - 1);
    }

    // StepSimulationItem item(UniqueKey id) {
    //   var item = items.firstWhere(
    //     (element) => element.id == id,
    //   );
    //   return item;
    // }

    // if (id + 2 < items.length &&
    //     0 <= id - 1 &&
    //     items[id - 1].orientation != items[id + 1].orientation) {
    //   var delWidth = items[id].width - wUnit * 0.6;
    //   items.removeAt(id - 1);
    //   items.removeAt(id - 1);
    //   items.removeAt(id - 1);
    //   if (id - 2 >= 0) {
    //     items[id - 2].width += items[id - 1].width + wUnit * 0.25;
    //   }

    //   items.removeAt(id - 1);
    //   for (int i = id - 1; i < items.length; i++) {
    //     items[i].left += delWidth;
    //     items[i].opacity = 1;
    //   }
    //   // items[id].height = 0;
    //   // items[id + 1].height = 0;
    //   // items[id].width = 0;
    //   // items[id + 1].width = 0;
    // }
  }

  // void handleItemHeight(StepSimulationItem item, bool isEnd) {
  //   if (isEnd) {
  //     item.rectangleHeight = item.rectangleHeight +=
  //   }
  // }

  Duration animationDuration = Duration(milliseconds: 200);
  Duration frameDuration =
      Duration(microseconds: const Duration(seconds: 1).inMicroseconds ~/ 120);

  void animateGemmation(StepSimulationItem item) {
    item.gemmationProgress = 2;
    var ind = items.indexWhere((element) => element.id == item.id);
    for (int i = ind + 1; i < items.length; i++) {
      items[i].position += Offset(0, -0.4 * hUnit);
      items[i].position += Offset(0, -1 * hUnit);
    }
    // int reps = (animationDuration.inMicroseconds / frameDuration.inMicroseconds)
    //     .toInt();
    // for (int i = 0; i < reps; i++) {
    //   Future.delayed(
    //       Duration(microseconds: i * frameDuration.inMicroseconds), () {

    //       });
    // }
  }

  void animateGemmationRetract(StepSimulationItem item) {
    item.gemmationProgress = 1;
    var ind = items.indexWhere((element) => element.id == item.id);
    for (int i = ind + 1; i < items.length; i++) {
      // items[i].position += Offset(0, 0.4 * hUnit);
      items[i].position += Offset(0, 1 * hUnit);
    }
    // int reps = (animationDuration.inMicroseconds / frameDuration.inMicroseconds)
    //     .toInt();
    // for (int i = 0; i < reps; i++) {
    //   Future.delayed(
    //       Duration(microseconds: i * frameDuration.inMicroseconds), () {

    //       });
    // }
  }

  void animatePreGemmation(StepSimulationItem item) async {
    //120hz
    item.gemmationProgress = 0.6;
    var ind = items.indexWhere((element) => element.id == item.id);
    for (int i = ind + 1; i < items.length; i++) {
      items[i].position += Offset(0, 0.4 * hUnit);
    }
    // item.rectangleHeight =
  }

  int animateGemmationDone(StepSimulationItem item) {
    //skopiowac item i rosunac nowy dodany
    var ind = items.indexWhere((element) => element.id == item.id);
    items.insert(
        ind,
        StepSimulationItem(UniqueKey(), item.position, item.width, item.height,
            item.opacity, item.orientation, defaultDuration, 1.0));
    items.removeAt(ind + 1);
    items.insert(
        ind + 1,
        FlatSimulationItem(
            UniqueKey(),
            Offset(items[ind].position.dx + wUnit / 2, items[ind].position.dy),
            0, //wUnit * 1.25
            hUnit / 7,
            1,
            Direction.up,
            defaultDuration,
            wUnit / 15)); //line

    items.insert(
      ind + 2,
      StepSimulationItem(
        UniqueKey(),
        Offset(items[ind].position.dx, items[ind].position.dy - hUnit),
        wUnit,
        hUnit,
        1,
        Direction.up,
        defaultDuration,
        1,
      ),
    );
    // items.insert(ind+2, element) //up arrow
    // items.insertAt(ind + 1, element);
    for (int i = ind + 3; i < items.length; i++) {
      items[i].position += Offset(wUnit, 0);
    }
    return ind + 1;
  }
}
