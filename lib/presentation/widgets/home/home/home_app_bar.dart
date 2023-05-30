import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_type.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../controllers/drawer_provider.dart';
import '../../../../controllers/home_provider.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/utilities/size_config.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import '../../../../core/constants/route_constants.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;
  final Color? color;
  const HomeAppBar({
    Key? key,
    this.parentScaffoldKey,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DrawerProvider appProvider =
        Provider.of<DrawerProvider>(context, listen: false);
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        height: SizeConfig.homeAppBarHeight,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(Theme.of(context).colorScheme.background ==
                    AppColors.black
                ? FixedAssets.backgroundDark
                : Theme.of(context).colorScheme.background == AppColors.clarity
                    ? FixedAssets.backgroundClassic
                    : FixedAssets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  FixedAssets.logo,
                  colorBlendMode: BlendMode.dstATop,
                  fit: BoxFit.contain,
                  width: 260,
                  height: 60,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  AppLocalizations.of(context)!.locale == const Locale("ar")
                      ? TURKIICONS.menu_right_1
                      : TURKIICONS.menu_left_1,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  appProvider.showDrawer();
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () => Navigator.pushNamed(context, search),
                    icon: Icon(
                      TURKIICONS.search,
                      size: 25,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                )
              ],
              elevation: 0,
            ),
            OrderType(
              visible: homeProvider.canPickup,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.homeAppBarHeight);
}
