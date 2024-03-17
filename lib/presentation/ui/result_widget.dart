import 'package:flutter/material.dart';

import '../../util/image_path.dart';

class ResultWidget extends StatelessWidget {
  final int score;
  final Function() onTap;

  const ResultWidget({
    Key? key,
    required this.score,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: FittedBox(
            child: Text(
              score.toString(),
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Image.asset(ImagePath.retry),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
