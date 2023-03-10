Map<String, dynamic> prune(Map<String, dynamic> topology) {
  Map<String, Map<String?, dynamic>> oldObjects = topology["objects"],
      newObjects = {};
  List<List<int>> oldArcs = topology["arcs"], newArcs = [];
  var oldArcsLength = oldArcs.length, oldIndex = -1, newIndex = -1;
  var newIndexByOldIndex = List<int?>.filled(oldArcsLength, null);

  void scanArc(int index) {
    if (index < 0) index = ~index;
    if (newIndexByOldIndex[index] != null) {
      newIndexByOldIndex[index] = 1;
    }
  }

  void scanArcs(List<int> arcs) {
    arcs.forEach(scanArc);
  }

  void scanMultiArcs(List<List<int>> arcs) {
    arcs.forEach(scanArcs);
  }

  scanGeometry(Map<String?, dynamic> input) {
    switch (input["type"]) {
      case "GeometryCollection":
        (input["geometries"] as List<Map<String?, dynamic>>)
            .forEach(scanGeometry);
        break;
      case "LineString":
        scanArcs(input["arcs"] as List<int>);
        break;
      case "MultiLineString":
        (input["arcs"] as List<List<int>>).forEach(scanArcs);
        break;
      case "Polygon":
        (input["arcs"] as List<List<int>>).forEach(scanArcs);
        break;
      case "MultiPolygon":
        (input["arcs"] as List<List<List<int>>>).forEach(scanMultiArcs);
        break;
    }
  }

  reindexArc(int oldIndex) => oldIndex < 0
      ? ~newIndexByOldIndex[~oldIndex]!
      : newIndexByOldIndex[oldIndex]!;

  reindexArcs(List<int> arcs) => arcs.map(reindexArc);

  reindexMultiArcs(List<List<int>> arcs) => arcs.map(reindexArcs);

  reindexGeometry(Map<String?, dynamic> input) {
    Map<String, dynamic> output;
    switch (input["type"]) {
      case "GeometryCollection":
        output = {
          "type": "GeometryCollection",
          "geometries": (input["geometries"] as List<Map<String?, dynamic>>)
              .map(reindexGeometry)
              .toList()
        };
        break;
      case "LineString":
        output = {
          "type": "LineString",
          "arcs": reindexArcs(input["arcs"] as List<int>).toList()
        };
        break;
      case "MultiLineString":
        output = {
          "type": "MultiLineString",
          "arcs": (input["arcs"] as List<List<int>>).map(reindexArcs).toList()
        };
        break;
      case "Polygon":
        output = {
          "type": "Polygon",
          "arcs": (input["arcs"] as List<List<int>>).map(reindexArcs).toList()
        };
        break;
      case "MultiPolygon":
        output = {
          "type": "MultiPolygon",
          "arcs": (input["arcs"] as List<List<List<int>>>)
              .map(reindexMultiArcs)
              .toList()
        };
        break;
      default:
        return input;
    }
    if (input["id"] != null) output["id"] = input["id"];
    if (input["bbox"] != null) output["bbox"] = input["bbox"];
    if (input["properties"] != null) output["properties"] = input["properties"];
    return output;
  }

  oldObjects.values.forEach(scanGeometry);

  while (++oldIndex < oldArcsLength) {
    if (newIndexByOldIndex[oldIndex] != null) {
      newIndexByOldIndex[oldIndex] = ++newIndex;
      newArcs[newIndex] = oldArcs[oldIndex];
    }
  }

  for (final o in oldObjects.entries) {
    newObjects[o.key] = reindexGeometry(o.value);
  }

  return {
    "type": "Topology",
    if (topology.containsKey("bbox")) "bbox": topology["bbox"],
    if (topology.containsKey("transform")) "transform": topology["transform"],
    "objects": newObjects,
    "arcs": newArcs
  };
}
