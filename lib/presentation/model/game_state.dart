import 'item_alignment_type.dart';

enum GameState {
  initial,
  answerShowing,
  answering,
  answerCompleted,
  cleared,
  result;

  ItemAlignmentType get alignmentType =>
      (this == GameState.answerShowing || this == GameState.answering || this == GameState.answerCompleted)
          ? ItemAlignmentType.active
          : ItemAlignmentType.idle;
}
