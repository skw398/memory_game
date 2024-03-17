import 'package:flutter/material.dart';
import 'dart:math' show min;

import '../../domain/input_checker.dart';
import '../../domain/input_result.dart';
import '../../domain/game_sequence.dart';
import '../../util/const.dart';
import '../../util/image_path.dart';
import '../model/game_state.dart';
import '../model/item.dart';
import 'start_button_widget.dart';
import 'result_widget.dart';
import 'item_widget.dart';
import 'tutorial_hand_widget.dart';

class MemoryGameWidget extends StatefulWidget {
  final List<Item> items;

  const MemoryGameWidget({
    super.key,
    required this.items,
  });

  @override
  MemoryGameWidgetState createState() => MemoryGameWidgetState();
}

class MemoryGameWidgetState extends State<MemoryGameWidget> {
  late final _gameSequence = GameSequence(itemCount: widget.items.length);
  late final _inputChecker = InputChecker(gameSequence: _gameSequence);

  var _state = GameState.initial;

  int? _scaleAnimatingItemIndex;
  late int? _score;

  bool _isPrecaching = false;

  @override
  void didChangeDependencies() async {
    setState(() => _isPrecaching = true);
    await Future.wait(ImagePath.all.map((path) {
      return precacheImage(AssetImage(path), context);
    }));
    setState(() => _isPrecaching = false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_isPrecaching) {
      return const Center(
        child: FractionallySizedBox(
          heightFactor: 0.1,
          child: AspectRatio(
            aspectRatio: 1,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final gameAreaSize = min(constraints.maxWidth, constraints.maxHeight) * 0.85;

        return Stack(
          fit: StackFit.expand,
          children: [
            AnimatedOpacity(
              opacity: _state == GameState.answerShowing ? 0.5 : 1.0,
              duration: const Duration(milliseconds: Const.baseDurationMs),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(ImagePath.background),
              ),
            ),
            Center(
              child: SizedBox(
                width: gameAreaSize,
                height: gameAreaSize,
                child: Stack(
                  children: [
                    ...widget.items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final shouldShowTutorialHand = _state == GameState.answering &&
                          _gameSequence.indices.length == 1 &&
                          _gameSequence.indices.first == index;

                      return AnimatedAlign(
                        curve: Curves.easeOutBack,
                        alignment: item.alignments.from(_state.alignmentType),
                        duration: const Duration(milliseconds: Const.baseDurationMs),
                        child: FractionallySizedBox(
                          widthFactor: 0.4,
                          heightFactor: 0.4,
                          child: Stack(
                            children: [
                              ItemWidget(
                                item: item,
                                onTap: () {
                                  if (_state != GameState.answering) return;
                                  final result = _inputChecker.check(index);
                                  _onReceiveInputResult(result);
                                },
                                disabled: (_state == GameState.answerShowing || _state == GameState.answerCompleted),
                                shouldScaleAnimating: _scaleAnimatingItemIndex == index,
                              ),
                              if (shouldShowTutorialHand)
                                IgnorePointer(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FractionallySizedBox(
                                      widthFactor: 0.4,
                                      heightFactor: 0.4,
                                      child: Transform.translate(
                                        offset: const Offset(0, 16),
                                        child: const TutorialHandWidget(),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                    if (_state == GameState.initial)
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.25,
                          child: StartButtonWidget(
                            onTap: () {
                              _gameSequence.refresh();
                              _showAnswer();
                            },
                          ),
                        ),
                      ),
                    if (_state == GameState.cleared)
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.7,
                          child: Image.asset(ImagePath.randomClearMessage),
                        ),
                      ),
                    if (_state == GameState.result)
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.25,
                          heightFactor: 0.3,
                          child: ResultWidget(
                            score: _score ?? 0,
                            onTap: () {
                              _gameSequence.refresh();
                              _showAnswer();
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onReceiveInputResult(InputResult result) async {
    switch (result) {
      case NotMatch(:int score):
        await _delay(amount: 1);
        setState(() {
          _score = score;
          _state = GameState.result;
        });

      case Match(:bool isAnswerCompleted):
        if (!isAnswerCompleted) break;

        setState(() => _state = GameState.answerCompleted);
        await _delay(amount: 1);
        setState(() => _state = GameState.cleared);
        await _delay(amount: 4);
        _gameSequence.next();
        _showAnswer();
    }
  }

  void _showAnswer() async {
    setState(() => _state = GameState.answerShowing);

    await _delay(amount: 3);
    for (int index in _gameSequence.indices) {
      setState(() => _scaleAnimatingItemIndex = index);
      await _delay(amount: 1);
      setState(() => _scaleAnimatingItemIndex = null);
      await _delay(amount: 1);
    }

    setState(() => _state = GameState.answering);
  }

  Future<void> _delay({required double amount}) async {
    final duration = Duration(milliseconds: (Const.baseDurationMs * amount).toInt());
    await Future.delayed(duration);
  }
}
