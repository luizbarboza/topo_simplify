import 'dart:io';

import 'package:test/test.dart';
import 'package:topo_client/topo_client.dart' as topojson;
import 'package:topo_simplify/topo_simplify.dart' as topojson;

void main() {
  group("topojson.simplify(topology, minWeight) <=", () {
    group("counties-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/counties-10m.json")
              .readAsStringSync());
      final presimplified = topojson.presimplify(topology);
      test("25e-2-quantile", () {
        final simplified = topojson.parseString(
            File("./test/topojson/us_atlas/simplified/counties-10m-p25e-2.json")
                .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 25e-2)!),
            simplified);
      });
      test("50e-2-quantile", () {
        final simplified = topojson.parseString(
            File("./test/topojson/us_atlas/simplified/counties-10m-p50e-2.json")
                .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 50e-2)!),
            simplified);
      });
      test("75e-2-quantile", () {
        final simplified = topojson.parseString(
            File("./test/topojson/us_atlas/simplified/counties-10m-p75e-2.json")
                .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 75e-2)!),
            simplified);
      });
    });
    group("counties-albers-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/counties-albers-10m.json")
              .readAsStringSync());
      final presimplified = topojson.presimplify(topology);
      test("25e-2-quantile", () {
        final simplified = topojson.parseString(File(
                "./test/topojson/us_atlas/simplified/counties-albers-10m-p25e-2.json")
            .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 25e-2)!),
            simplified);
      });
      test("50e-2-quantile", () {
        final simplified = topojson.parseString(File(
                "./test/topojson/us_atlas/simplified/counties-albers-10m-p50e-2.json")
            .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 50e-2)!),
            simplified);
      });
      test("75e-2-quantile", () {
        final simplified = topojson.parseString(File(
                "./test/topojson/us_atlas/simplified/counties-albers-10m-p75e-2.json")
            .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 75e-2)!),
            simplified);
      });
    });

    group("states-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/states-10m.json").readAsStringSync());
      final presimplified = topojson.presimplify(topology);
      test("25e-2-quantile", () {
        final simplified = topojson.parseString(
            File("./test/topojson/us_atlas/simplified/states-10m-p25e-2.json")
                .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 25e-2)!),
            simplified);
      });
      test("50e-2-quantile", () {
        final simplified = topojson.parseString(
            File("./test/topojson/us_atlas/simplified/states-10m-p50e-2.json")
                .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 50e-2)!),
            simplified);
      });
      test("75e-2-quantile", () {
        final simplified = topojson.parseString(
            File("./test/topojson/us_atlas/simplified/states-10m-p75e-2.json")
                .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 75e-2)!),
            simplified);
      });
    });
    group("states-albers-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/states-albers-10m.json")
              .readAsStringSync());
      final presimplified = topojson.presimplify(topology);
      test("25e-2-quantile", () {
        final simplified = topojson.parseString(File(
                "./test/topojson/us_atlas/simplified/states-albers-10m-p25e-2.json")
            .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 25e-2)!),
            simplified);
      });
      test("50e-2-quantile", () {
        final simplified = topojson.parseString(File(
                "./test/topojson/us_atlas/simplified/states-albers-10m-p50e-2.json")
            .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 50e-2)!),
            simplified);
      });
      test("75e-2-quantile", () {
        final simplified = topojson.parseString(File(
                "./test/topojson/us_atlas/simplified/states-albers-10m-p75e-2.json")
            .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 75e-2)!),
            simplified);
      });
    });

    group("nation-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/nation-10m.json").readAsStringSync());
      final presimplified = topojson.presimplify(topology);
      test("25e-2-quantile", () {
        final simplified = topojson.parseString(
            File("./test/topojson/us_atlas/simplified/nation-10m-p25e-2.json")
                .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 25e-2)!),
            simplified);
      });
      test("50e-2-quantile", () {
        final simplified = topojson.parseString(
            File("./test/topojson/us_atlas/simplified/nation-10m-p50e-2.json")
                .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 50e-2)!),
            simplified);
      });
      test("75e-2-quantile", () {
        final simplified = topojson.parseString(
            File("./test/topojson/us_atlas/simplified/nation-10m-p75e-2.json")
                .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 75e-2)!),
            simplified);
      });
    });
    group("nation-albers-10m", () {
      final topology = topojson.parseString(
          File("./test/topojson/us_atlas/nation-albers-10m.json")
              .readAsStringSync());
      final presimplified = topojson.presimplify(topology);
      test("25e-2-quantile", () {
        final simplified = topojson.parseString(File(
                "./test/topojson/us_atlas/simplified/nation-albers-10m-p25e-2.json")
            .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 25e-2)!),
            simplified);
      });
      test("50e-2-quantile", () {
        final simplified = topojson.parseString(File(
                "./test/topojson/us_atlas/simplified/nation-albers-10m-p50e-2.json")
            .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 50e-2)!),
            simplified);
      });
      test("75e-2-quantile", () {
        final simplified = topojson.parseString(File(
                "./test/topojson/us_atlas/simplified/nation-albers-10m-p75e-2.json")
            .readAsStringSync());
        expect(
            topojson.simplify(
                presimplified, topojson.quantile(presimplified, 75e-2)!),
            simplified);
      });
    });
  });
}
