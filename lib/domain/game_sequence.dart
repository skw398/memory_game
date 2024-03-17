import 'dart:math' show Random;

class GameSequence {
  final int _itemCount;

  late List<int> _indices;
  List<int> get indices => List<int>.unmodifiable(_indices);

  GameSequence({required int itemCount}) : _itemCount = itemCount;

  int get _randomIndex => Random().nextInt(_itemCount);

  void refresh() => _indices = [_randomIndex];
  void next() => _indices.add(_randomIndex);
}
