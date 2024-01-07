class AnimatedProp<T> {
  final T value;
  final int millis;

  AnimatedProp({required this.value, required this.millis});

  AnimatedProp.zero({required this.value, this.millis = 0});
}
