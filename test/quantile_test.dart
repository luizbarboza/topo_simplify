import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:topo_parse/topo_parse.dart' as topojson;
import 'package:topo_simplify/topo_simplify.dart' as topojson;

void main() {
  group("topojson.quantile(topology, p) <=", () {
    group("counties-10m", () {
      final quantile = json.decode(
          File("./test/topojson/us_atlas/quantile/counties-10m.json")
              .readAsStringSync());
      final topology = topojson.presimplify(topojson.parseString(
          File("./test/topojson/us_atlas/counties-10m.json")
              .readAsStringSync()));
      test("25e-2", () {
        expect(topojson.quantile(topology, 25e-2), quantile["25e-2"]);
      });
      test("50e-2", () {
        expect(topojson.quantile(topology, 50e-2), quantile["50e-2"]);
      });
      test("75e-2", () {
        expect(topojson.quantile(topology, 75e-2), quantile["75e-2"]);
      });
    });
    group("counties-albers-10m", () {
      final quantile = json.decode(
          File("./test/topojson/us_atlas/quantile/counties-albers-10m.json")
              .readAsStringSync());
      final topology = topojson.presimplify(topojson.parseString(
          File("./test/topojson/us_atlas/counties-albers-10m.json")
              .readAsStringSync()));
      test("25e-2", () {
        expect(topojson.quantile(topology, 25e-2), quantile["25e-2"]);
      });
      test("50e-2", () {
        expect(topojson.quantile(topology, 50e-2), quantile["50e-2"]);
      });
      test("75e-2", () {
        expect(topojson.quantile(topology, 75e-2), quantile["75e-2"]);
      });
    });

    group("states-10m", () {
      final quantile = json.decode(
          File("./test/topojson/us_atlas/quantile/states-10m.json")
              .readAsStringSync());
      final topology = topojson.presimplify(topojson.parseString(
          File("./test/topojson/us_atlas/states-10m.json").readAsStringSync()));
      test("25e-2", () {
        expect(topojson.quantile(topology, 25e-2), quantile["25e-2"]);
      });
      test("50e-2", () {
        expect(topojson.quantile(topology, 50e-2), quantile["50e-2"]);
      });
      test("75e-2", () {
        expect(topojson.quantile(topology, 75e-2), quantile["75e-2"]);
      });
    });
    group("states-albers-10m", () {
      final quantile = json.decode(
          File("./test/topojson/us_atlas/quantile/states-albers-10m.json")
              .readAsStringSync());
      final topology = topojson.presimplify(topojson.parseString(
          File("./test/topojson/us_atlas/states-albers-10m.json")
              .readAsStringSync()));
      test("25e-2", () {
        expect(topojson.quantile(topology, 25e-2), quantile["25e-2"]);
      });
      test("50e-2", () {
        expect(topojson.quantile(topology, 50e-2), quantile["50e-2"]);
      });
      test("75e-2", () {
        expect(topojson.quantile(topology, 75e-2), quantile["75e-2"]);
      });
    });

    group("nation-10m", () {
      final quantile = json.decode(
          File("./test/topojson/us_atlas/quantile/nation-10m.json")
              .readAsStringSync());
      final topology = topojson.presimplify(topojson.parseString(
          File("./test/topojson/us_atlas/nation-10m.json").readAsStringSync()));
      test("25e-2", () {
        expect(topojson.quantile(topology, 25e-2), quantile["25e-2"]);
      });
      test("50e-2", () {
        expect(topojson.quantile(topology, 50e-2), quantile["50e-2"]);
      });
      test("75e-2", () {
        expect(topojson.quantile(topology, 75e-2), quantile["75e-2"]);
      });
    });
    group("nation-albers-10m", () {
      final quantile = json.decode(
          File("./test/topojson/us_atlas/quantile/nation-albers-10m.json")
              .readAsStringSync());
      final topology = topojson.presimplify(topojson.parseString(
          File("./test/topojson/us_atlas/nation-albers-10m.json")
              .readAsStringSync()));
      test("25e-2", () {
        expect(topojson.quantile(topology, 25e-2), quantile["25e-2"]);
      });
      test("50e-2", () {
        expect(topojson.quantile(topology, 50e-2), quantile["50e-2"]);
      });
      test("75e-2", () {
        expect(topojson.quantile(topology, 75e-2), quantile["75e-2"]);
      });
    });
  });
}
