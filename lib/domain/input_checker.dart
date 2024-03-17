import 'game_sequence.dart';
import 'input_result.dart';

class InputChecker {
  final GameSequence _gameSequence;
  int _inputCount = 0;

  InputChecker({required GameSequence gameSequence}) : _gameSequence = gameSequence;

  InputResult check(int index) {
    _inputCount++;

    if (_gameSequence.indices[_inputCount - 1] != index) {
      _inputCount = 0;
      return InputResult.notMatch(score: _gameSequence.indices.length - 1);
    } else if (_gameSequence.indices.length == _inputCount) {
      _inputCount = 0;
      return InputResult.match(isAnswerCompleted: true);
    } else {
      return InputResult.match(isAnswerCompleted: false);
    }
  }
}
