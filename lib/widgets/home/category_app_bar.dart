import 'package:flutter/material.dart';
import 'package:new_turki/provider/app_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import 'package:provider/provider.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  final Function onTap;
  const CategoryAppBar({
    required this.parentScaffoldKey,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Theme.of(context).backgroundColor == Colors.black
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).primaryColor,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/turki_gold.png",
                colorBlendMode: BlendMode.dstATop,
                fit: BoxFit.contain,
                width: 200,
                height: 50,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                  AppLocalizations.of(context)!.locale == Locale("ar")
                      ? TURKIICONS.menu_right_1
                      : TURKIICONS.menu_left_1,
                  color: Theme.of(context).backgroundColor ==
                          Color.fromRGBO(243, 224, 177, 1)
                      ? Color.fromRGBO(243, 224, 177, 1)
                      : Colors.white),
              onPressed: () {
                appProvider.showDrawer();
              },
            ),
            elevation: 0,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
