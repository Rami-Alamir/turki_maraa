import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/hex_color.dart';
import 'package:new_turki/widgets/home/category_card_g5.dart';
import 'old/category_card_g1.dart';
import 'package:new_turki/models/category_data.dart';

class CategoriesLarge2 extends StatelessWidget {
  final List<Data> categoriesList;

  const CategoriesLarge2({required this.categoriesList});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 10),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        itemCount: categoriesList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return CategoryCardG5(
            categoryId: categoriesList[index].id!,
            image: categoriesList[index].imageUrl!,
            title: AppLocalizations.of(context)!.locale == Locale("ar")
                ? categoriesList[index].titleAr!
                : categoriesList[index].titleEn!,
            titleAr: categoriesList[index].titleAr!,
            titleEn: categoriesList[index].titleEn!,
            color: HexColor(categoriesList[index].backgroundColor1!),
            color2: HexColor(categoriesList[index].backgroundColor2!),
          );
        });
  }
}
