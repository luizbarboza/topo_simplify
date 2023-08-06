import 'dart:io';

import 'package:test/test.dart';
import 'package:topo_parse/topo_parse.dart' as topojson;
import 'package:topo_simplify/topo_simplify.dart' as topojson;

void main() {
  group("topojson.presimplify(topology) <=", () {
    test("counties-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/counties-10m.json")
              .readAsStringSync());
      final presimplified = topojson.parseString(
          File("./test/topojson/us_atlas/presimplified/counties-10m.json")
              .readAsStringSync());
      expect(topojson.presimplify(topology), fixArcsEndpoints(presimplified));
    });
    test("counties-albers-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/counties-albers-10m.json")
              .readAsStringSync());
      final presimplified = topojson.parseString(File(
              "./test/topojson/us_atlas/presimplified/counties-albers-10m.json")
          .readAsStringSync());
      expect(topojson.presimplify(topology), fixArcsEndpoints(presimplified));
    });

    test("states-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/states-10m.json").readAsStringSync());
      final presimplified = topojson.parseString(
          File("./test/topojson/us_atlas/presimplified/states-10m.json")
              .readAsStringSync());
      expect(topojson.presimplify(topology), fixArcsEndpoints(presimplified));
    });
    test("states-albers-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/states-albers-10m.json")
              .readAsStringSync());
      final presimplified = topojson.parseString(
          File("./test/topojson/us_atlas/presimplified/states-albers-10m.json")
              .readAsStringSync());
      expect(topojson.presimplify(topology), fixArcsEndpoints(presimplified));
    });

    test("nation-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/nation-10m.json").readAsStringSync());
      final presimplified = topojson.parseString(
          File("./test/topojson/us_atlas/presimplified/nation-10m.json")
              .readAsStringSync());
      expect(topojson.presimplify(topology), fixArcsEndpoints(presimplified));
    });
    test("nation-albers-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/nation-albers-10m.json")
              .readAsStringSync());
      final presimplified = topojson.parseString(
          File("./test/topojson/us_atlas/presimplified/nation-albers-10m.json")
              .readAsStringSync());
      expect(topojson.presimplify(topology), fixArcsEndpoints(presimplified));
    });
  });
}

Map<String?, dynamic> fixArcsEndpoints(Map<String?, dynamic> topology) {
  for (final arc in topology["arcs"] as List<List<List<Object?>>>) {
    var n = arc.length - 1;
    arc[0][2] = double.infinity;
    arc[n][2] = double.infinity;
  }
  return topology;
}
