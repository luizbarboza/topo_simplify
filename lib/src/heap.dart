class Heap<E extends HeapEntry<E>> {
  final _elements = <E>[];
  var _size = 0;

  int add(E object) {
    if (_elements.length > _size) {
      _elements[object._ = _size] = object;
    } else {
      _elements.add(object.._ = _size);
    }
    _up(object, _size++);
    return _size;
  }

  E? removeFirst() {
    if (_size <= 0) return null;
    E removed = _elements[0], object;
    if (--_size > 0) {
      object = _elements[_size];
      _down(_elements[object._ = 0] = object, 0);
    }
    return removed;
  }

  int? remove(E removed) {
    var i = removed._;
    E object;
    if (_elements[i] != removed) return null; // invalid request
    if (i != --_size) {
      object = _elements[_size];
      (object.compareTo(removed) < 0 ? _up : _down)(
          _elements[object._ = i] = object, i);
    }
    return i;
  }

  void _up(E object, int i) {
    while (i > 0) {
      var j = ((i + 1) >> 1) - 1, parent = _elements[j];
      if (object.compareTo(parent) >= 0) break;
      _elements[parent._ = i] = parent;
      _elements[object._ = i = j] = object;
    }
  }

  void _down(E object, int i) {
    while (true) {
      var r = (i + 1) << 1, l = r - 1, j = i, child = _elements[j];
      if (l < _size && _elements[l].compareTo(child) < 0) {
        child = _elements[j = l];
      }
      if (r < _size && _elements[r].compareTo(child) < 0) {
        child = _elements[j = r];
      }
      if (j == i) break;
      _elements[child._ = i] = child;
      _elements[object._ = i = j] = object;
    }
  }
}

abstract class HeapEntry<E extends HeapEntry<E>> implements Comparable<E> {
  late int _;
}
