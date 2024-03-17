import 'dart:math' show Random;

class ImagePath {
  static const String background = 'assets/background.jpg';

  static const String start = 'assets/start.png';
  static const String retry = 'assets/retry.png';

  static const String hand = 'assets/hand.png';

  static const String tiger = 'assets/tiger.png';
  static const String elephant = 'assets/elephant.png';
  static const String bear = 'assets/bear.png';
  static const String lion = 'assets/lion.png';

  static const List<String> _clearMessages = [
    'assets/clear_message_1.png',
    'assets/clear_message_2.png',
    'assets/clear_message_3.png',
    'assets/clear_message_4.png',
    'assets/clear_message_5.png',
    'assets/clear_message_6.png',
  ];

  static String get randomClearMessage => _clearMessages[Random().nextInt(_clearMessages.length)];

  static List<String> all = [
    background,
    start,
    retry,
    hand,
    tiger,
    elephant,
    bear,
    lion,
    ..._clearMessages,
  ];
}
