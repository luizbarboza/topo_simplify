import 'filter_attached.dart';
import 'filter_weight.dart';
import 'prune.dart';

/// To filter a topology, you supply a ring [Filter] function to [filter].
///
/// The [Filter] function is invoked for each ring in the input topology, being
/// passed two arguments: the [ring], specified as an array of points where each
/// point is a two-element array of numbers, and the [interior] flag. If
/// [interior] is false, the given [ring] is the exterior ring of a polygon; if
/// [interior] is true, the given [ring] is an interior ring (a hole). The
/// [Filter] function must then return true if the ring should be preserved, or
/// false if the ring should be removed.
typedef Filter = bool Function(List<int> ring, bool interior);

/// Returns a shallow copy of the specified [topology], removing any rings that
/// fail the specified [filter] function.
///
/// See [filterAttached] and [filterWeight] for built-in filter implementations.
///
/// If a resulting Polygon geometry object has no rings, it is replaced with a
/// null geometry; likewise, empty polygons are removed from MultiPolygon
/// geometry objects, and if the resulting MultiPolygon geometry object has no
/// polygons, it is replaced with a null geometry; likewise, any null geometry
/// objects are removed from GeometryCollection objects, and if the resulting
/// GeometryCollection is empty, it is replaced with a null geometry.
///
/// After any geometry objects are removed from the [topology], the resulting
/// topology is pruned, removing any unused arcs. As a result, this operation
/// typically changes the arc indexes of the topology.
Map<String, dynamic> filter(Map<String?, dynamic> topology,
    [Filter filter = _filterTrue]) {
  Map<String?, Map<String?, dynamic>> oldObjects = topology["objects"],
      newObjects = {};

  bool filterExteriorRing(List<int> ring) => filter(ring, false);

  bool filterInteriorRing(List<int> ring) => filter(ring, true);

  List<List<int>>? filterRings(List<List<int>> arcs) => arcs.isNotEmpty &&
          filterExteriorRing(
              arcs[0]) // if the exterior is small, ignore any holes
      ? [arcs[0]] + arcs.sublist(1).where(filterInteriorRing).toList()
      : null;

  Map<String?, dynamic> filterGeometry(Map<String?, dynamic> input) {
    Map<String, dynamic> output;
    switch (input["type"]) {
      case "Polygon":
        var arcs = filterRings(input["arcs"]);
        output =
            arcs != null ? {"type": "Polygon", "arcs": arcs} : {"type": null};
        break;
      case "MultiPolygon":
        var arcs =
            (input["arcs"] as List<List<List<int>>>).map(filterRings).toList();
        output = arcs.isNotEmpty
            ? {"type": "MultiPolygon", "arcs": arcs}
            : {"type": null};
        break;
      case "GeometryCollection":
        var geometries = (input["geometries"] as List<Map<String?, dynamic>>)
            .map(filterGeometry)
            .where(_filterNotNull)
            .toList();
        output = geometries.isNotEmpty
            ? {"type": "GeometryCollection", "geometries": geometries}
            : {"type": null};
        break;
      default:
        return input;
    }
    if (input["id"] != null) output["id"] = input["id"];
    if (input["bbox"] != null) output["bbox"] = input["bbox"];
    if (input["properties"] != null) output["properties"] = input["properties"];
    return output;
  }

  for (final o in oldObjects.entries) {
    newObjects[o.key] = filterGeometry(o.value);
  }

  return prune({
    "type": "Topology",
    if (topology.containsKey("bbox")) "bbox": topology["bbox"],
    if (topology.containsKey("transform")) "transform": topology["transform"],
    "objects": newObjects,
    "arcs": topology["arcs"]
  });
}

bool _filterTrue(_, __) => true;

bool _filterNotNull(Map<String?, dynamic> geometry) => geometry["type"] != null;
