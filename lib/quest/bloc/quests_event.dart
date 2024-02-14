part of 'quests_bloc.dart';

@immutable
sealed class QuestsEvent {}

abstract class TrigEvent extends QuestsEvent {
  bool isEqual(TrigEvent event) {
    if (runtimeType == event.runtimeType) {
      return true;
    }
    return false;
  }
}

class TrigEventInsertedUp extends TrigEvent {}

class TrigEventInsertedDown extends TrigEvent {}

class TrigEventMerged extends TrigEvent {}

class TrigEventSplited extends TrigEvent {}

class TrigEventScrolled extends TrigEvent {}

class TrigEventInsertedOpposite extends TrigEvent {}

class TrigEventEquationValue extends TrigEvent {
  final List<int> numbers;

  TrigEventEquationValue({required this.numbers});

  @override
  bool isEqual(TrigEvent event) {
    return super.isEqual(event) &&
        (event is TrigEventEquationValue && listEquals(numbers, event.numbers));
  }
}
