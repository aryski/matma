import 'package:matma/stairs_simulation/stairs_component.dart';

enum Stair { up, down, flat, futureFlat }

class Stairs {
  final List<Stair> stairs = [];
  bool isFlat(Stair stair) => stair == Stair.flat || stair == Stair.futureFlat;

  Stairs(List<int> numbers) {
    var result = [Stair.flat];
    for (int i = 0; i < numbers.length; i++) {
      for (int j = 0; j < numbers[i].abs(); j++) {
        if (numbers[i] > 0) {
          result.add(Stair.up);
        } else {
          result.add(Stair.down);
        }
        result.add(Stair.flat);
      }
      result.add(Stair.flat);
    }
    stairs.addAll(result);
  }

  int maxHeightSinceIndex(int index) {
    var current_sum = 0;
    for (int i = 0; i < index; i++) {
      if (stairs[i] == Stair.up) {
        current_sum += 1;
      } else if (stairs[i] == Stair.down) {
        current_sum -= 1;
      }
    }
    var sum = 0;
    var max = 0;
    for (int i = index; i < stairs.length; i++) {
      if (stairs[i] == Stair.up) {
        sum += 1;
        if (sum > max) {
          max = sum;
        }
      } else if (stairs[i] == Stair.down) {
        sum -= 1;
      }
    }
    //current sum;
    //max;
    return current_sum + max;
    //o ile do gory max leci
  }

  int maxLowSinceIndex(int index) {
    var current_sum = 0;
    for (int i = 0; i < index; i++) {
      if (stairs[i] == Stair.up) {
        current_sum += 1;
      } else if (stairs[i] == Stair.down) {
        current_sum -= 1;
      }
    }
    var sum = 0;
    var min = 0;
    for (int i = index; i < stairs.length; i++) {
      if (stairs[i] == Stair.up) {
        sum += 1;
      } else if (stairs[i] == Stair.down) {
        sum -= 1;
        if (sum < min) {
          min = sum;
        }
      }
    }
    //current sum;
    //max;
    return current_sum + min;
    //o ile do gory max leci
  }

  int lines() {
    var result = 0;
    for (int i = 0; i < stairs.length; i++) {
      if (isFlat(stairs[i])) {
        result++;
      }
    }
    return result;
  }

  void scroll(int index, int scrollDeltaNormalized) {
    if (stairs[index] == Stair.up) {
      if (scrollDeltaNormalized > 0) {
        if (lines() < 60) {
          if (maxHeightSinceIndex(index) < 7) {
            stairs.insert(index, Stair.futureFlat);
            stairs.insert(index, Stair.up);
          }
        }
      }
    }
    if (stairs[index] == Stair.down) {
      if (scrollDeltaNormalized < 0) {
        if (lines() < 60) {
          if (maxLowSinceIndex(index) > -7) {
            stairs.insert(index, Stair.futureFlat);
            stairs.insert(index, Stair.down);
          }
        }
      }
    }

    if (stairs[index] == Stair.flat) {
      if (scrollDeltaNormalized > 0) {
        if (lines() < 60) {
          for (int i = 0; i < scrollDeltaNormalized && i < 3; i++) {
            stairs.insert(index, Stair.flat);
          }
        }
      } else {
        //i kiedy po lewej lub po prawej jest kreska
        if (index - 1 >= 0 && isFlat(stairs[index - 1])) {
          stairs.removeAt(index);
        } else if (index + 1 < stairs.length && isFlat(stairs[index + 1])) {
          stairs.removeAt(index);
        } else if (index - 1 >= 0 &&
            index + 1 < stairs.length &&
            stairs[index - 1] != stairs[index + 1]) {
          stairs.removeAt(index + 1);
          stairs.removeAt(index);
          stairs.removeAt(index - 1);

          //gdyby byla kreska po lewej lub po prawj to bysmy tu nie doszli wiec jedyna opcja jest taka ze sa upy i downy
        }
      }
    }
  }

  @override
  String toString() {
    int sum = 0;
    String res = "";
    List<int> summary = [];
    for (int i = 0; i < stairs.length; i++) {
      if (stairs[i] == Stair.up) {
        sum += 1;
      } else if (stairs[i] == Stair.down) {
        sum -= 1;
      } else if (stairs[i] == Stair.flat &&
              (i + 1 >= stairs.length || stairs[i + 1] == Stair.flat) ||
          (i - 1 >= 0 && stairs[i + 1] != stairs[i - 1])) {
        if (sum != 0) {
          if (sum >= 0 && !summary.isEmpty) {
            res += " + ";
          } else if (sum < 0) {
            res += " - ";
          }
          sum = sum.abs();
          res += "$sum";
          summary.add(sum);
        }
        sum = 0;
      }
    }
    return res;
  }

  StairsComponent generateStairsComponent(double unit, double horizUnit) {
    return StairsComponent(stairs, unit, horizUnit);
  }
}
