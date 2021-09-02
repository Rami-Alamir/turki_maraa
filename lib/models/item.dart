import 'dart:ui';

import 'package:flutter/material.dart';

class Item {
  final String? image;
  final String? title;
  final int? price;
  final double? discount;
  late String? tag;
  late Color? tagColor;

  Item(
      {this.image,
      this.tag = '',
      this.tagColor = Colors.transparent,
      this.title,
      this.price,
      this.discount = 0});
}
