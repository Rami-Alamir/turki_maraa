import 'package:flutter/material.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/hex_color.dart';
import 'package:provider/provider.dart';
import 'category_card_g1.dart';

class CategoriesG1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    return CategoryCardG1(
      categoryId: _homeProvider.categoryData.data![0].id!,
      image: _homeProvider.categoryData.data![0].imageUrl!,
      title: AppLocalizations.of(context)!.locale == Locale("ar")
          ? _homeProvider.categoryData.data![0].titleAr!
          : _homeProvider.categoryData.data![0].titleEn!,
      color: HexColor(_homeProvider.categoryData.data![0].backgroundColor1!),
      color2: HexColor(_homeProvider.categoryData.data![0].backgroundColor2!),
    );
  }
}
