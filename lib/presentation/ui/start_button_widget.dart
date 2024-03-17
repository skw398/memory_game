import 'package:flutter/material.dart';

import '../../util/image_path.dart';

class StartButtonWidget extends StatelessWidget {
  final Function() onTap;

  const StartButtonWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
          child: Image.asset(
            ImagePath.start,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
