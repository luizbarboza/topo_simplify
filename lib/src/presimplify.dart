import 'package:topo_client/topo_client.dart';

import 'heap.dart';
import 'iterable_extension.dart';
import 'planar.dart';
import 'simplify.dart';
import 'triangle.dart';

List<Object?> copy(List<Object?> point, [_]) => [point[0], point[1]];

/// Returns a shallow copy of the specified [topology] where each coordinate of
/// each arc is assigned a *z*-value according to the specified [weight]
/// function.
///
/// If [weight] is not specified, it defaults to [planarTriangleArea]. If the
/// input [topology] is delta-encoded (that is, if a [topology]\["transform"\]
/// is present), this transform is removed in the returned output topology.
///
/// The returned presimplified topology can be passed to [simplify] to remove
/// coordinates below a desired weight threshold.
Map<String, dynamic> presimplify(Map<String?, dynamic> topology,
    [num Function(List<List<Object?>>) weight = planarTriangleArea]) {
  var point = topology["transform"] != null
          ? pointTransform(topology["transform"])
          : copy,
      heap = Heap<TriangleEntry>();

  var arcs = (topology["arcs"] as List<List<List<Object?>>>).map((arc) {
    var triangles = <TriangleEntry>[];
    TriangleEntry? triangle;
    num maxWeight = 0;
    int i, n;

    arc = arc.mapIndexed(point).toList();

    n = arc.length - 1;
    for (i = 1; i < n; ++i) {
      triangle = TriangleEntry([arc[i - 1], arc[i], arc[i + 1]]);
      triangle[1].add(weight(triangle));
      triangles.add(triangle);
      heap.add(triangle);
    }

    arc[0].add(double.infinity);
    arc[n].add(double.infinity);

    n = triangles.length;
    for (i = 0; i < n; ++i) {
      triangle = triangles[i];
      if (i > 0) triangle.previous = triangles[i - 1];
      if (i < n - 1) triangle.next = triangles[i + 1];
    }

    void update(TriangleEntry triangle) {
      heap.remove(triangle);
      triangle[1][2] = weight(triangle);
      heap.add(triangle);
    }

    while ((triangle = heap.removeFirst()) != null) {
      var previous = triangle!.previous, next = triangle.next;

      // If the weight of the current point is less than that of the previous
      // point to be eliminated, use the latter’s weight instead. This ensures
      // that the current point cannot be eliminated without eliminating
      // previously- eliminated points.
      if ((triangle[1][2] as num) < maxWeight) {
        triangle[1][2] = maxWeight;
      } else {
        maxWeight = (triangle[1][2] as num);
      }

      if (previous != null) {
        previous.next = next;
        previous[2] = triangle[2];
        update(previous);
      }

      if (next != null) {
        next.previous = previous;
        next[0] = triangle[0];
        update(next);
      }
    }

    return arc;
  }).toList();

  return {
    "type": "Topology",
    if (topology.containsKey("bbox")) "bbox": topology["bbox"],
    "objects": topology["objects"],
    "arcs": arcs
  };
}
