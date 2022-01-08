import 'package:flutter/material.dart';
import 'package:new_turki/models/category_data.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/hex_color.dart';
import 'category_card_g1.dart';

class CategoriesG1 extends StatelessWidget {
  final Data categoryData;

  const CategoriesG1({required this.categoryData});
  @override
  Widget build(BuildContext context) {
    return CategoryCardG1(
      categoryId: categoryData.id!,
      image: categoryData.imageUrl!,
      title: AppLocalizations.of(context)!.locale == Locale("ar")
          ? categoryData.titleAr!
          : categoryData.titleEn!,
      color: HexColor(categoryData.backgroundColor1!),
      color2: HexColor(categoryData.backgroundColor2!),
    );
  }
}
