import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'categories.dart';
import '../../../../controllers/home_provider.dart';
import '../../../../models/category_data.dart';

class CategoriesGroup extends StatelessWidget {
  const CategoriesGroup({super.key});
  @override
  Widget build(BuildContext context) {
    return categoriesGroup(context.watch<HomeProvider>().categoryData);
  }
}

Widget categoriesGroup(CategoryData? categoryData) {
  int length = categoryData?.data?.length ?? 0;
  return length == 0
      ? const SizedBox.shrink()
      : Categories(categoriesList: categoryData!.data!);
}
