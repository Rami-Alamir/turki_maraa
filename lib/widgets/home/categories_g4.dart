import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/hex_color.dart';
import 'package:provider/provider.dart';
import 'category_card.dart';

class CategoriesG4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        itemCount: _homeProvider.categoryData.data!.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            categoryId: _homeProvider.categoryData.data![index].id!,
            scaleFactor: index % 2 == 0 ? 1.8 : 1.1,
            image: _homeProvider.categoryData.data![index].imageUrl!,
            title: AppLocalizations.of(context)!.locale == Locale("ar")
                ? _homeProvider.categoryData.data![index].titleAr!
                : _homeProvider.categoryData.data![index].titleEn!,
            color: HexColor(
                _homeProvider.categoryData.data![index].backgroundColor1!),
            color2: HexColor(
                _homeProvider.categoryData.data![index].backgroundColor2!),
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index % 2 == 0 ? 1.6 : 1.1);
        });
  }
}
