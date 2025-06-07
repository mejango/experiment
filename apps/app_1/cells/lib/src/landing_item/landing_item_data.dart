import 'package:flutter/material.dart';
import 'package:table/index.dart';
import 'package:decorated_text/index.dart';
import 'package:sorting/index.dart';

class LandingItemData extends StreamableTableRowData with TimeSortable {
  final WeightDecoratedText title;
  final String? description;
  final Image? image;
  final int section;
  final int timestamp;

  LandingItemData({
    required this.title,
    this.description = '',
    this.image,
    required this.timestamp,
    int? section,
    String? key,
  })  : section = section ?? 0,
        super(key: key);
}
