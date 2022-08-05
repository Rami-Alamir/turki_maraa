import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/hex_color.dart';
import 'package:new_turki/widgets/home/category_card_g3.dart';
import 'package:new_turki/models/category_data.dart';

class CategoriesG3 extends StatelessWidget {
  final List<Data> categoriesList;

  const CategoriesG3({required this.categoriesList});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        itemCount: 3,
        itemBuilder: (context, index) {
          return CategoryCardG3(
            categoryId: categoriesList[index].id!,
            scaleFactor: index == 0 ? 1.8 : 0.8,
            titleAr: categoriesList[index].titleAr!,
            titleEn: categoriesList[index].titleEn!,
            image: categoriesList[index].imageUrl!,
            title: AppLocalizations.of(context)!.locale == Locale("ar")
                ? categoriesList[index].titleAr!
                : categoriesList[index].titleEn!,
            color: HexColor(categoriesList[index].backgroundColor1!),
            color2: HexColor(categoriesList[index].backgroundColor2!),
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index == 0 ? 1.6 : 0.8);
        });
  }
}
