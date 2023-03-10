/// Returns the [planar area](http://mathworld.wolfram.com/TriangleArea.html) of
/// the specified [triangle], which is an array of three points \[\[*x*₀,
/// *y*₀\], \[*x*₁, *y*₁\], \[*x*₂, *y*₂\]\].
///
/// This implementation is agnostic to winding order; the returned value is
/// always non-negative.
num planarTriangleArea(List<List<Object?>> triangle) {
  var a = triangle[0], b = triangle[1], c = triangle[2];
  return (((a[0] as num) - (c[0] as num)) * ((b[1] as num) - (a[1] as num)) -
              ((a[0] as num) - (b[0] as num)) * ((c[1] as num) - (a[1] as num)))
          .abs() /
      2;
}

/// Returns the [planar area](http://mathworld.wolfram.com/PolygonArea.html) of
/// the specified [ring], which is an array of points \[\[*x*₀, *y*₀\], \[*x*₁,
/// *y*₁\], …\].
///
/// The first point must be equal to the last point. This implementation is
/// agnostic to winding order; the returned value is always non-negative.
num planarRingArea(List<List<Object?>> ring) {
  var i = -1, n = ring.length, area = 0.0;
  List<Object?> a, b = ring[n - 1];
  while (++i < n) {
    a = b;
    b = ring[i];
    area += (a[0] as num) * (b[1] as num) - (a[1] as num) * (b[0] as num);
  }
  return (area).abs() / 2;
}
