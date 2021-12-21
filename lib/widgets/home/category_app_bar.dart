import 'package:flutter/material.dart';
import 'package:new_turki/provider/app_provider.dart';
import 'package:new_turki/utilities/ra7_icons.dart';
import 'package:new_turki/widgets/shared/logo.dart';
import 'package:provider/provider.dart';
import 'address_container.dart';
import 'order_type.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  final Function onTap;
  final String address;
  const CategoryAppBar(
      {required this.parentScaffoldKey,
      required this.onTap,
      required this.address});
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
            title: Logo(type: 1),
            centerTitle: true,
            leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(RA7ICONS.menu__1_,
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
          OrderType(
            visible: true,
          ),
          AddressContainer(title: address),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(250);
}
