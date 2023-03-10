import 'dart:collection';

import 'heap.dart';

class TriangleEntry extends HeapEntry<TriangleEntry>
    with ListMixin<List<Object?>> {
  final List<List<Object?>> _positions;
  TriangleEntry? previous;
  TriangleEntry? next;

  TriangleEntry(this._positions);

  @override
  int get length => _positions.length;

  @override
  set length(int length) => _positions.length = length;

  @override
  operator [](int index) => _positions[index];

  @override
  void operator []=(int index, value) => _positions[index] = value;

  @override
  int compareTo(other) => (this[1][2] as num).compareTo(other[1][2] as num);
}
