import 'presimplify.dart';

/// Returns a shallow copy of the specified [topology] where every arc
/// coordinate whose *z*-value is lower than [minWeight] is removed.
///
/// Only the *x* and *y* dimensions of the coordinates are preserved in the
/// returned topology. If [minWeight] is not specified, it defaults to
/// [double.minPositive]. This method has no effect on Point and MultiPoint
/// geometries.
///
/// See [presimplify] to assign *z*-value for each coordinate.
Map<String, dynamic> simplify(Map<String?, dynamic> topology,
    [num minWeight = double.minPositive]) {
  // Remove points whose weight is less than the minimum weight.
  var arcs = (topology["arcs"] as List<List<List<Object?>>>).map((input) {
    var output = <List<num>>[];

    for (final point in input) {
      if ((point[2] as num) >= minWeight) {
        output.add([(point[0] as num), (point[1] as num)]);
      }
    }

    return output;
  }).toList();

  return {
    "type": "Topology",
    if (topology.containsKey("tansform")) "transform": topology["transform"],
    if (topology.containsKey("bbox")) "bbox": topology["bbox"],
    "objects": topology["objects"],
    "arcs": arcs
  };
}
