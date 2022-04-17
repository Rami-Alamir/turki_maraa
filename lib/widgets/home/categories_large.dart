import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/hex_color.dart';
import 'category_card_g1.dart';
import 'package:new_turki/models/category_data.dart';

class CategoriesLarge extends StatelessWidget {
  final List<Data> categoriesList;

  const CategoriesLarge({required this.categoriesList});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        itemCount: categoriesList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return CategoryCardG1(
            categoryId: categoriesList[index].id!,
            image: categoriesList[index].imageUrl!,
            title: AppLocalizations.of(context)!.locale == Locale("ar")
                ? categoriesList[index].titleAr!
                : categoriesList[index].titleEn!,
            titelAr: categoriesList[index].titleAr!,
            titelEn: categoriesList[index].titleEn!,
            color: HexColor(categoriesList[index].backgroundColor1!),
            color2: HexColor(categoriesList[index].backgroundColor2!),
          );
        });
  }
}
