import 'package:flutter/material.dart';

import '../../util/const.dart';
import '../../util/image_path.dart';

class TutorialHandWidget extends StatefulWidget {
  const TutorialHandWidget({super.key});

  @override
  TutorialHandWidgetState createState() => TutorialHandWidgetState();
}

class TutorialHandWidgetState extends State<TutorialHandWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: Const.baseDurationMs * 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: Image.asset(ImagePath.hand),
    );
  }
}
