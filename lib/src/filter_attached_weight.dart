import 'filter.dart';
import 'filter_attached.dart';
import 'filter_weight.dart';

/// Returns a ring [filter] function that returns true if the weight of the
/// specified *ring* is greater than or equal to the specified [minWeight]
/// threshold or the specified *ring* shares an arc with any other object in the
/// [topology].
Filter filterAttachedWeight(Map<String?, dynamic> topology,
    [num minWeight = double.minPositive,
    num Function(List<List<Object?>>, bool)? weight]) {
  var a = filterAttached(topology),
      w = filterWeight(topology, minWeight, weight);
  return (ring, interior) => a(ring, interior) || w(ring, interior);
}
