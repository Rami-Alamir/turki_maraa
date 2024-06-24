import 'package:flutter/material.dart';
import 'banners.dart';
import '../../shared/logo.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import '../../../../models/banners_data.dart';

class FoodAppBar extends StatelessWidget {
  final bool changeColor;
  final BannersData bannersData;

  const FoodAppBar(
      {super.key, required this.changeColor, required this.bannersData});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        title: Logo(
          type: changeColor ? 2 : 1,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: changeColor
                ? Theme.of(context).colorScheme.primary
                : AppColors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        pinned: true,
        actionsIconTheme: IconThemeData(
          color: changeColor
              ? Theme.of(context).colorScheme.primary
              : AppColors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, search),
              icon: const Icon(
                TURKIICONS.search,
                size: 25,
              ),
            ),
          )
        ],
        elevation: 0.3,
        expandedHeight: 230.0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: const Text('',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.0,
              )),
          background: BannersSlider(bannersData: bannersData),
        ));
  }
}
