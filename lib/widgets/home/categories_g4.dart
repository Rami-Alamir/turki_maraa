import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/hex_color.dart';
import 'category_card.dart';
import 'package:new_turki/models/category_data.dart';

class CategoriesG4 extends StatelessWidget {
  final List<Data> categoriesList;

  const CategoriesG4({required this.categoriesList});
  @override
  Widget build(BuildContext context) {
    // List<Color> list = [
    //   Theme.of(context).primaryColor,
    //   Color.fromRGBO(200, 173, 88, 0.9),
    //   Color.fromRGBO(51, 79, 45, 1),
    //   Color.fromRGBO(3, 25, 4, 1),
    //   Color.fromRGBO(101, 1, 1, 1),
    //   Color.fromRGBO(200, 173, 88, 1),
    // ];
    // List<Color> list2 = [
    //   Theme.of(context).primaryColor.withOpacity(0.9),
    //   Color.fromRGBO(200, 173, 88, 0.9),
    //   Color.fromRGBO(51, 79, 45, 0.97),
    //   Color.fromRGBO(3, 25, 4, 0.9),
    //   Color.fromRGBO(101, 1, 1, 0.9),
    //   Color.fromRGBO(212, 175, 55, 1),
    // ];
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            categoryId: categoriesList[index].id!,
            scaleFactor: index % 2 == 0 ? 1.8 : 1.1,
            image: categoriesList[index].imageUrl!,

            title: AppLocalizations.of(context)!.locale == Locale("ar")
                ? categoriesList[index].titleAr!
                : categoriesList[index].titleEn!,
            titelAr: categoriesList[index].titleAr!,
            titelEn: categoriesList[index].titleEn!,
            color: HexColor(categoriesList[index].backgroundColor1!),
            color2: HexColor(categoriesList[index].backgroundColor2!),
            // color: list[index],
            // color2: list2[index],
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index % 2 == 0 ? 1.6 : 1.1);
        });
  }
}
