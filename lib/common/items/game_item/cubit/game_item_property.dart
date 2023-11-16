class AnimatedProp<T> {
  final T value;
  final int duration;

  AnimatedProp({required this.value, required this.duration});

  AnimatedProp.zero({required this.value, this.duration = 0});
}
