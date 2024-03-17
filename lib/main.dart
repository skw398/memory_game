import 'package:flutter/material.dart';

import 'presentation/model/item_alignments.dart';
import 'presentation/model/item.dart';
import 'presentation/ui/memory_game_widget.dart';
import 'util/image_path.dart';

void main() => runApp(const MemoryGame());

class MemoryGame extends StatelessWidget {
  const MemoryGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: MemoryGameWidget(
          items: [
            Item(
              imagePath: ImagePath.tiger,
              alignments: ItemAlignments(idle: Alignment.topLeft, active: Alignment.topCenter),
            ),
            Item(
              imagePath: ImagePath.elephant,
              alignments: ItemAlignments(idle: Alignment.topRight, active: Alignment.centerRight),
            ),
            Item(
              imagePath: ImagePath.bear,
              alignments: ItemAlignments(idle: Alignment.bottomRight, active: Alignment.bottomCenter),
            ),
            Item(
              imagePath: ImagePath.lion,
              alignments: ItemAlignments(idle: Alignment.bottomLeft, active: Alignment.centerLeft),
            )
          ],
        ),
      ),
    );
  }
}
