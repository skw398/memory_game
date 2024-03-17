import 'package:flutter/material.dart' show Alignment;

import 'item_alignment_type.dart';

class ItemAlignments {
  final Alignment idle;
  final Alignment active;

  const ItemAlignments({
    required this.idle,
    required this.active,
  });

  Alignment from(ItemAlignmentType type) => type == ItemAlignmentType.idle ? idle : active;
}
