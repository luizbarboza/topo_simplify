import 'simplify.dart';

/// Returns the [p]-quantile of the weighted points in the given
/// presimplified [topology], where [p] is a number in the
/// range \[0, 1\].
///
/// The quantile value is then typically passed as the *minWeight* to
/// [simplify]. For example, the median weight can be computed using [p] = 0.5,
/// the first quartile at [p] = 0.25, and the third quartile at [p] = 0.75. This
/// implementation uses the
/// [R-7 method](https://en.wikipedia.org/wiki/Quantile#Quantiles_of_a_population),
/// which is the default for the R programming language and Excel.
num? quantile(Map<String?, dynamic> topology, num p) {
  var array = <num>[];

  for (final arc in (topology["arcs"] as List<List<List<Object?>>>)) {
    for (final point in arc) {
      if ((point[2] as num).isFinite) {
        // Ignore endpoints, whose weight is Infinity.
        array.add((point[2] as num));
      }
    }
  }

  return array.isNotEmpty ? _quantile(array..sort(_descending), p) : 0;
}

num? _quantile(List<num> array, num p) {
  int n;
  if ((n = array.length) == 0) return null;
  if (p <= 0 || n < 2) return array[0];
  if (p >= 1) return array[n - 1];
  var h = (n - 1) * p, i = h.floor(), a = array[i], b = array[i + 1];
  return a + (b - a) * (h - i);
}

int _descending(num a, num b) => b.compareTo(a);
