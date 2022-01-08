import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/hex_color.dart';
import 'category_card.dart';
import 'package:new_turki/models/category_data.dart';

class CategoriesG2 extends StatelessWidget {
  final List<Data> categoriesList;

  const CategoriesG2({required this.categoriesList});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        itemCount: 2,
        itemBuilder: (context, index) {
          return CategoryCard(
            categoryId: categoriesList[index].id!,
            scaleFactor: 1.8,
            image: categoriesList[index].imageUrl!,
            title: AppLocalizations.of(context)!.locale == Locale("ar")
                ? categoriesList[index].titleAr!
                : categoriesList[index].titleEn!,
            color: HexColor(categoriesList[index].backgroundColor1!),
            color2: HexColor(categoriesList[index].backgroundColor2!),
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, 1.6);
        });
  }
}
