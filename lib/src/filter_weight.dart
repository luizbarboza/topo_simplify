import 'package:topo_client/topo_client.dart';

import 'filter.dart';
import 'planar.dart';

/// Returns a ring [filter] function that returns true if the weight of the
/// specified *ring* is greater than or equal to the specified [minWeight]
/// threshold.
///
/// If [minWeight] is not specified, it defaults to [double.minPositive]. If
/// [weight] is not specified, it defaults to [planarRingArea].
Filter filterWeight(Map<String?, dynamic> topology,
    [num minWeight = double.minPositive,
    num Function(List<List<Object?>>, bool)? weight]) {
  weight ??= (ring, _) => planarRingArea(ring);

  return (ring, interior) =>
      weight!(
          feature(topology, {
            "type": "Polygon",
            "arcs": [ring]
          })["geometry"]["coordinates"][0],
          interior) >=
      minWeight;
}
