import 'package:flutter/material.dart';
import 'category_card.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/hex_color.dart';
import '../../../models/category_data.dart';

class Categories extends StatelessWidget {
  final List<Data> categoriesList;

  const Categories({Key? key, required this.categoriesList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        itemCount: categoriesList.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return CategoryCard(
            categoryId: categoriesList[index].id!,
            image: categoriesList[index].imageUrl!,
            title: AppLocalizations.of(context)!.locale == const Locale("ar")
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
