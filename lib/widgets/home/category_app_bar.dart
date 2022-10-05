import 'package:flutter/material.dart';
import 'package:new_turki/provider/app_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import 'package:provider/provider.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  final bool back;
  const CategoryAppBar({
    required this.parentScaffoldKey,
    this.back = false,
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
                width: 150,
                height: 32,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                  back
                      ? Icons.arrow_back_ios
                      : AppLocalizations.of(context)!.locale == Locale("ar")
                          ? TURKIICONS.menu_right_1
                          : TURKIICONS.menu_left_1,
                  color: Theme.of(context).backgroundColor ==
                          Color.fromRGBO(243, 224, 177, 1)
                      ? Color.fromRGBO(243, 224, 177, 1)
                      : Colors.white),
              onPressed: () {
                back ? Navigator.of(context).pop() : appProvider.showDrawer();
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
