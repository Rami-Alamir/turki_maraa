import 'package:flutter/material.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
import 'package:new_turki/widgets/shared/logo.dart';

import 'banners.dart';

class FoodAppBar extends StatelessWidget {
  final bool changeColor;
  final banners;

  const FoodAppBar({required this.changeColor, required this.banners});
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
                ? Theme.of(context).primaryColor
                : Theme.of(context).backgroundColor ==
                        Color.fromRGBO(243, 224, 177, 1)
                    ? Color.fromRGBO(243, 224, 177, 1)
                    : Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        pinned: true,
        actionsIconTheme: IconThemeData(
          color: changeColor
              ? Theme.of(context).primaryColor
              : Theme.of(context).backgroundColor ==
                      Color.fromRGBO(243, 224, 177, 1)
                  ? Color.fromRGBO(243, 224, 177, 1)
                  : Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, "/Search"),
              icon: Icon(
                RA7ICONS.search,
                size: 25,
              ),
            ),
          )
        ],
        elevation: 0.3,
        expandedHeight: 230.0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text('',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              )),
          background: Banners(imgList: banners),
        ));
  }
}
