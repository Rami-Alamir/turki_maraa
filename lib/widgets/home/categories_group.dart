import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/models/category_data.dart';
import 'categories_g1.dart';
import 'categories_g2.dart';
import 'categories_g3.dart';
import 'categories_g4.dart';
import 'categories_large.dart';
import 'not_supported_area.dart';

class CategoriesGroup extends StatelessWidget {
  final CategoryData categoryData;

  const CategoriesGroup({required this.categoryData});
  @override
  Widget build(BuildContext context) {
    return categoriesGroup(categoryData.data?.length ?? 0, categoryData);
  }
}

Widget categoriesGroup(int length, categoryData) {
  if (SizeConfig.screenWidth! > 590)
    return CategoriesLarge(categoriesList: categoryData.data!);
  else
    switch (length) {
      case 0:
        return Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: NotSupportedArea(),
        );
      case 1:
        return CategoriesG1(
          categoryData: categoryData.data![0],
        );
      case 2:
        return CategoriesG2(categoriesList: categoryData.data!);
      case 3:
        return CategoriesG3(categoriesList: categoryData.data!);
      default:
        return CategoriesG4(categoriesList: categoryData.data!);
    }
}
