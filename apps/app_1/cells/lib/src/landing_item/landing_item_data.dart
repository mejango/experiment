import 'package:flutter/material.dart';
import 'package:table/index.dart';
import 'package:decorated_text/index.dart';
import 'package:sorting/index.dart';

class LandingItemData extends StreamableTableRowData with TimeSortable implements Comparable<LandingItemData> {
  final WeightDecoratedText title;
  final String? description;
  final Image? image;
  final int section;
  final int timestamp;
  final String? ticker;

  LandingItemData({
    required this.title,
    this.description = '',
    this.image,
    required this.timestamp,
    required this.section,
    String? key,
    this.ticker,
  })  : super(key: key);

  @override
  int compareTo(LandingItemData other) {
    // Sort by timestamp in descending order (newest first)
    return other.timestamp.compareTo(timestamp);
  }
}
