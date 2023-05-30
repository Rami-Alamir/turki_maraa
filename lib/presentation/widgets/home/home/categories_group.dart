import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'categories.dart';
import 'not_supported_area.dart';
import '../../../../controllers/home_provider.dart';

class CategoriesGroup extends StatelessWidget {
  const CategoriesGroup({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    return categoriesGroup(homeProvider.categoryData?.data?.length ?? 0,
        homeProvider.categoryData);
  }
}

Widget categoriesGroup(int length, categoryData) {
  return length == 0
      ? const NotSupportedArea()
      : Categories(categoriesList: categoryData.data!);
}
