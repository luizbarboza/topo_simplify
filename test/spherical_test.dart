// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:test/test.dart';
import 'package:topo_simplify/topo_simplify.dart' as topojson;

void main() {
  test(
      "topojson.sphericalRingArea(ring) returns the area of the specified ring",
      () {
    expect(
        topojson.sphericalRingArea([
          [0, 0],
          [0, 0.1],
          [0.1, 0],
          [0, 0]
        ], false),
        closeTo(0.000001523087872198469, 1e-6));
    expect(
        topojson.sphericalRingArea([
          [-64.66070178517852, 18.33986913231323],
          [-64.66079715091509, 18.33994007490749],
          [-64.66074946804680, 18.33994007490749],
          [-64.66070178517852, 18.33986913231323]
        ], false),
        closeTo(4.89051671736539e-13, 1e-6));
    expect(
        topojson.sphericalRingArea([
          [0, 0],
          [0, 90],
          [90, 0],
          [0, 0]
        ], false),
        closeTo(pi / 2, 1e-6));
    expect(
        topojson.sphericalRingArea([
          [0, 0],
          [0, 90],
          [90, 0],
          [0, -90],
          [0, 0]
        ], false),
        closeTo(pi, 1e-6));
    expect(
        topojson.sphericalRingArea([
          [0, 0],
          [-90, 0],
          [180, 0],
          [90, 0],
          [0, 0]
        ], false),
        closeTo(2 * pi, 1e-6));
    expect(
        topojson.sphericalRingArea([
          [0, 0],
          [90, 0],
          [180, 0],
          [-90, 0],
          [0, 0]
        ], false),
        closeTo(2 * pi, 1e-6));
    expect(
        topojson.sphericalRingArea([
          [0, 0],
          [0, 90],
          [180, 0],
          [0, -90],
          [0, 0]
        ], false),
        closeTo(2 * pi, 1e-6));
    expect(
        topojson.sphericalRingArea([
          [0, 0],
          [0, -90],
          [180, 0],
          [0, 90],
          [0, 0]
        ], false),
        closeTo(2 * pi, 1e-6));
  });

  test("topojson.sphericalRingArea(ring) does care about winding order", () {
    expect(
        topojson.sphericalRingArea([
          [0, 0],
          [0.1, 0],
          [0, 0.1],
          [0, 0]
        ], false),
        closeTo(12.5663690912713, 1e-6));
    expect(
        topojson.sphericalRingArea(
            [
              [0, 0],
              [0, 90],
              [90, 0],
              [0, 0]
            ].reversed.toList(),
            false),
        closeTo(4 * pi - pi / 2, 1e-6));
    expect(
        topojson.sphericalRingArea(
            [
              [0, 0],
              [0, 90],
              [90, 0],
              [0, -90],
              [0, 0]
            ].reversed.toList(),
            false),
        closeTo(3 * pi, 1e-6));
    expect(
        topojson.sphericalRingArea(
            [
              [0, 0],
              [-90, 0],
              [180, 0],
              [90, 0],
              [0, 0]
            ].reversed.toList(),
            false),
        closeTo(2 * pi, 1e-6));
  });

  test(
      "topojson.sphericalTriangleArea(triangle) returns the area of the specified triangle",
      () {
    expect(
        topojson.sphericalTriangleArea([
          [0, 0],
          [0, 0.1],
          [0.1, 0]
        ]),
        closeTo(0.000001523087872198469, 1e-6));
    expect(
        topojson.sphericalTriangleArea([
          [0, 0],
          [0, 90],
          [90, 0]
        ]),
        closeTo(pi / 2, 1e-6));
  });

  test("topojson.sphericalTriangleArea(triangle) does care about winding order",
      () {
    expect(
        topojson.sphericalTriangleArea([
          [0, 0],
          [0.1, 0],
          [0, 0.1]
        ]),
        closeTo(0.000001523087872198469, 1e-6));
    expect(
        topojson.sphericalTriangleArea([
          [0, 0],
          [90, 0],
          [0, 90]
        ]),
        closeTo(pi / 2, 1e-6));
  });
}
