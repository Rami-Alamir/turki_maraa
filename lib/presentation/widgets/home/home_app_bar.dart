import 'package:flutter/material.dart';
import '../../../controllers/drawer_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;
  final bool back;
  final Color? color;
  const HomeAppBar({
    Key? key,
    this.parentScaffoldKey,
    this.back = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DrawerProvider appProvider =
        Provider.of<DrawerProvider>(context, listen: false);
    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Theme.of(context).backgroundColor == Colors.black
                ? Theme.of(context).colorScheme.secondary
                : color ?? Theme.of(context).primaryColor,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                FixedAssets.appName,
                colorBlendMode: BlendMode.dstATop,
                fit: BoxFit.contain,
                width: 200,
                height: 30,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                  back
                      ? Icons.arrow_back_ios
                      : AppLocalizations.of(context)!.locale ==
                              const Locale("ar")
                          ? TURKIICONS.menu_right_1
                          : TURKIICONS.menu_left_1,
                  color: Theme.of(context).backgroundColor ==
                          const Color.fromRGBO(243, 224, 177, 1)
                      ? const Color.fromRGBO(243, 224, 177, 1)
                      : Colors.white),
              onPressed: () {
                if (back) {
                  Navigator.of(context).pop();
                } else {
                  appProvider.showDrawer();
                }
              },
            ),
            elevation: 0,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
