import 'package:flutter/material.dart';
import 'package:new_turki/provider/app_provider.dart';
import 'package:new_turki/utilities/ra7_icons.dart';
import 'package:new_turki/widgets/home_header.dart';
import 'package:provider/provider.dart';

import 'address_container.dart';
import 'logo.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  final Function onTap;
  const CategoryAppBar({required this.parentScaffoldKey, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Logo(type: 1),
            centerTitle: true,
            leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(RA7ICONS.menu__1_, color: Colors.white),
              onPressed: () {
                appProvider.showDrawer();
              },
              // onPressed: () => parentScaffoldKey.currentState!.openDrawer(),

              // onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            elevation: 0,
          ),
          Container(
            width: double.infinity,
            height: 25,
            color: Theme.of(context).primaryColor,
          ),
          AddressContainer(title: 'الياسمين'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(210);
}
