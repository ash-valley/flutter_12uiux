extension ListEx<E> on List<E> {
  Iterable<T> mapWithIndex<T>(T Function(E element, int index) toElement) =>
      asMap().entries.map((e) => toElement(e.value, e.key));
}
