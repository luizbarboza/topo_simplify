extension IterableExtension<T> on Iterable<T> {
  Iterable<R> mapIndexed<R>(R Function(T element, int index) convert) sync* {
    var index = 0;
    for (final element in this) {
      yield convert(element, index++);
    }
  }
}
