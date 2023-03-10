// ignore_for_file: lines_longer_than_80_chars

import 'package:test/test.dart';
import 'package:topo_simplify/topo_simplify.dart' as topojson;

void main() {
  test("topojson.planarRingArea(ring) returns the area of the specified ring",
      () {
    expect(
        topojson.planarRingArea([
          [0, 0],
          [1, 0],
          [0, 1],
          [0, 0]
        ]),
        0.5);
    expect(
        topojson.planarRingArea([
          [0, 0],
          [1, 0],
          [1, 1],
          [0, 1],
          [0, 0]
        ]),
        1);
  });

  test("topojson.planarRingArea(ring) doesn’t care about winding order", () {
    expect(
        topojson.planarRingArea([
          [0, 0],
          [0, 1],
          [1, 0],
          [0, 0]
        ]),
        0.5);
    expect(
        topojson.planarRingArea([
          [0, 0],
          [0, 1],
          [1, 1],
          [1, 0],
          [0, 0]
        ]),
        1);
  });

  test(
      "topojson.planarTriangleArea(triangle) returns the area of the specified triangle",
      () {
    expect(
        topojson.planarTriangleArea([
          [0, 0],
          [1, 0],
          [0, 1]
        ]),
        0.5);
  });

  test("topojson.planarTriangleArea(triangle) doesn’t care about winding order",
      () {
    expect(
        topojson.planarTriangleArea([
          [0, 0],
          [0, 1],
          [1, 0]
        ]),
        0.5);
  });
}
