import 'package:flutter/material.dart';
import 'package:new_turki/widgets/home_header.dart';

import 'address_container.dart';
import 'logo.dart';

class AccentAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [],
          ),
          AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Logo(type: 1),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            elevation: 0,
          ),
          HomeHeader(),
          AddressContainer(title: 'Yasmin'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(210);
}
