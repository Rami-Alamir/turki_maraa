import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_type.dart';
import '../../shared/logo.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../controllers/drawer_provider.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/utilities/size_config.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import '../../../../core/constants/route_constants.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;
  final Color? color;
  const HomeAppBar({
    super.key,
    this.parentScaffoldKey,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        height: SizeConfig.homeAppBarHeight,
        decoration: Theme.of(context).primaryColor == AppColors.nd94
            ? const BoxDecoration(
                color: AppColors.nd94,
              )
            : BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage(
                      Theme.of(context).colorScheme.onSurface == AppColors.black
                          ? FixedAssets.backgroundDark
                          : Theme.of(context).colorScheme.onSurface ==
                                  AppColors.clarity
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
              title: const Logo(),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  AppLocalizations.of(context)!.locale == const Locale("ar")
                      ? TURKIICONS.menu_right_1
                      : TURKIICONS.menu_left_1,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  context.read<DrawerProvider>().showDrawer();
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
            const OrderType(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.homeAppBarHeight);
}
