import 'package:flutter/material.dart';
import '../../../models/category_data.dart';
import 'categories.dart';
import 'not_supported_area.dart';

class CategoriesGroup extends StatelessWidget {
  final CategoryData? categoryData;

  const CategoriesGroup({Key? key, required this.categoryData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return categoriesGroup(categoryData?.data?.length ?? 0, categoryData);
  }
}

Widget categoriesGroup(int length, categoryData) {
  return length == 0
      ? const NotSupportedArea()
      : Categories(categoriesList: categoryData.data!);
}
