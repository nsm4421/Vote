extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  Iterable<List<T>> chunked(int size) sync* {
    if (size <= 0) return;
    var chunk = <T>[];
    for (final item in this) {
      chunk.add(item);
      if (chunk.length == size) {
        yield chunk;
        chunk = <T>[];
      }
    }
    if (chunk.isNotEmpty) yield chunk;
  }

  List<T> sortedBy<K extends Comparable>(K Function(T element) keySelector) {
    final list = toList();
    list.sort((a, b) => keySelector(a).compareTo(keySelector(b)));
    return list;
  }
}

extension IterableNumExtension on Iterable<num> {
  num sum() => fold<num>(0, (total, element) => total + element);
  double average() => isEmpty ? 0 : sum() / length;
}

extension IterableDistinctExtension<T> on Iterable<T> {
  List<T> distinctBy<K>(K Function(T element) keySelector) {
    final seen = <K>{};
    final result = <T>[];
    for (final element in this) {
      final key = keySelector(element);
      if (seen.add(key)) {
        result.add(element);
      }
    }
    return result;
  }
}
