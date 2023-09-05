part of 'floor_bloc.dart';

@immutable
sealed class FloorEvent {}

class FloorEventHoverStart extends FloorEvent {}

class FloorEventHoverEnd extends FloorEvent {}

class FloorEventUpdatePosition extends FloorEvent {
  final Offset delta;

  FloorEventUpdatePosition(this.delta);
}

class FloorEventUpdateSize extends FloorEvent {
  final Size delta;

  FloorEventUpdateSize(this.delta);
}
