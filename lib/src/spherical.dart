import 'dart:math';

const _tau = 2 * pi, _quarterPi = pi / 4, _radians = pi / 180;

num _halfArea(List<List<Object?>> ring, bool closed) {
  var i = 0, n = ring.length;
  var point = ring[closed ? i++ : n - 1];
  num sum = 0,
      lambda0,
      lambda1 = (point[0] as num) * _radians,
      phi1 = ((point[1] as num) * _radians) / 2 + _quarterPi,
      cosPhi0,
      cosPhi1 = cos(phi1),
      sinPhi0,
      sinPhi1 = sin(phi1);

  for (; i < n; ++i) {
    point = ring[i];
    lambda0 = lambda1;
    lambda1 = (point[0] as num) * _radians;
    phi1 = ((point[1] as num) * _radians) / 2 + _quarterPi;
    cosPhi0 = cosPhi1;
    cosPhi1 = cos(phi1);
    sinPhi0 = sinPhi1;
    sinPhi1 = sin(phi1);

    // Spherical excess E for a spherical triangle with vertices: south pole,
    // previous point, current point.  Uses a formula derived from Cagnoli’s
    // theorem.  See Todhunter, Spherical Trig. (1871), Sec. 103, Eq. (2).
    // See https://pub.dev/documentation/d4_geo/latest/d4_geo/geoArea.html
    var dLambda = lambda1 - lambda0,
        sdLambda = dLambda >= 0 ? 1 : -1,
        adLambda = sdLambda * dLambda,
        k = sinPhi0 * sinPhi1,
        u = cosPhi0 * cosPhi1 + k * cos(adLambda),
        v = k * sdLambda * sin(adLambda);
    sum += atan2(v, u);
  }

  return sum;
}

/// Returns the
/// [spherical area](https://en.wikipedia.org/wiki/Spherical_trigonometry#Area_and_spherical_excess)
/// of the specified [ring], which is an array of points \[\[*x*₀, *y*₀\],
/// \[*x*₁, *y*₁\], …\] where *x* and *y* represent longitude and latitude in
/// degrees, respectively.
///
/// The first point must be equal to the last point. This implementation uses
/// [d4_geo](https://pub.dev/documentation/d4_geo/latest/d4_geo/d4_geo-library.html)’s
/// [winding order convention](https://bl.ocks.org/mbostock/a7bdfeb041e850799a8d3dce4d8c50c8)
/// to determine which side of the polygon is the inside: polygons smaller than
/// a hemisphere must be clockwise, while polygons
/// [larger than a hemisphere](https://bl.ocks.org/mbostock/6713736) must be
/// anticlockwise. If [interior] is true, the opposite winding order is used.
/// This winding order convention is also used by
/// [ESRI shapefiles](https://github.com/mbostock/shapefile); however, it is the
/// **opposite** convention of GeoJSON’s
/// [RFC 7946](https://tools.ietf.org/html/rfc7946#section-3.1.6).
num sphericalRingArea(List<List<Object?>> ring, bool interior) {
  var sum = _halfArea(ring, true);
  if (interior) sum *= -1;
  return (sum < 0 ? _tau + sum : sum) * 2;
}

num sphericalTriangleArea(List<List<Object?>> t) =>
    _halfArea(t, false).abs() * 2;
