import 'dart:math' show Random;

import 'package:flutter/material.dart';

import '../../util/const.dart';
import '../model/item.dart';

class ItemWidget extends StatefulWidget {
  final Item item;
  final Function() onTap;
  final bool disabled;
  final bool shouldScaleAnimating;

  const ItemWidget({
    Key? key,
    required this.item,
    required this.onTap,
    required this.disabled,
    required this.shouldScaleAnimating,
  }) : super(key: key);

  @override
  ItemWidgetState createState() => ItemWidgetState();
}

class ItemWidgetState extends State<ItemWidget> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scale;

  late AnimationController _swayController;
  late Animation<double> _radian;

  @override
  void initState() {
    _configureAnimations();
    super.initState();
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldScaleAnimating) _performScaleAnimation();

    return GestureDetector(
      onTap: () {
        if (widget.disabled) return;
        widget.onTap();
        _performScaleAnimation();
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_scaleController, _swayController]),
        builder: (context, child) {
          return Transform(
            transform: Matrix4.rotationZ(_radian.value),
            alignment: FractionalOffset.center,
            child: Transform.scale(
              scale: _scale.value,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 16,
                    )
                  ],
                ),
                child: ClipOval(
                  child: MouseRegion(
                    cursor: widget.disabled ? MouseCursor.defer : SystemMouseCursors.click,
                    child: Image.asset(widget.item.imagePath),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _performScaleAnimation() {
    _scaleController.forward(from: 0.0);
  }

  void _configureAnimations() {
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: Const.baseDurationMs ~/ 2),
      vsync: this,
    );
    _scale = Tween<double>(begin: 1.0, end: 1.25).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scaleController.reverse();
        }
      });

    _swayController = AnimationController(
      duration: Duration(milliseconds: Random().nextInt(Const.baseDurationMs * 3) + Const.baseDurationMs * 3),
      vsync: this,
    )..repeat(reverse: true);
    _radian = Tween<double>(begin: -0.1, end: 0.1).animate(_swayController);
  }

  void _disposeAnimations() {
    _scaleController.dispose();
    _swayController.dispose();
  }
}
