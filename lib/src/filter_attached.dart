import 'filter.dart';

/// Returns a ring [filter] function that returns true if the specified *ring*
/// shares an arc with any other object in the [topology].
Filter filterAttached(Map<String?, dynamic> topology) {
  // arc index -> index of unique associated ring, or -1 if used by multiple
  // rings
  var ownerByArc =
      List<int?>.filled((topology["arcs"] as List<List<int>>).length, null);
  var ownerIndex = 0;

  void testArcs(List<List<int>> arcs) {
    for (var i = 0, n = arcs.length; i < n; ++i, ++ownerIndex) {
      for (var ring = arcs[i], j = 0, m = ring.length; j < m; ++j) {
        var arc = ring[j];
        if (arc < 0) arc = ~arc;
        var owner = ownerByArc[arc];
        if (owner == null) {
          ownerByArc[arc] = ownerIndex;
        } else if (owner != ownerIndex) {
          ownerByArc[arc] = -1;
        }
      }
    }
  }

  void testGeometry(Map<String?, dynamic> o) {
    switch (o["type"]) {
      case "GeometryCollection":
        (o["geometries"] as List<Map<String?, dynamic>>).forEach(testGeometry);
        break;
      case "Polygon":
        testArcs(o["arcs"] as List<List<int>>);
        break;
      case "MultiPolygon":
        (o["arcs"] as List<List<List<int>>>).forEach(testArcs);
        break;
    }
  }

  // ignore: prefer_foreach
  for (final o in (topology["objects"] as List<Map<String?, dynamic>>)) {
    testGeometry(o);
  }

  return (ring, _) {
    for (int j = 0, m = ring.length, arc; j < m; ++j) {
      if (ownerByArc[(arc = ring[j]) < 0 ? ~arc : arc] == -1) {
        return true;
      }
    }
    return false;
  };
}
