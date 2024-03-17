sealed class InputResult {
  const InputResult();

  static InputResult notMatch({required int score}) => NotMatch._(score);
  static InputResult match({required bool isAnswerCompleted}) => Match._(isAnswerCompleted);
}

class NotMatch extends InputResult {
  final int score;

  const NotMatch._(this.score) : super();
}

class Match extends InputResult {
  final bool isAnswerCompleted;

  const Match._(this.isAnswerCompleted) : super();
}
