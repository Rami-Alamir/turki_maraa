import 'package:flutter/material.dart';
import '../../../core/constants/route_constants.dart';
import '../../../models/banners_data.dart';
import '../../../core/utilities/r_a7_i_c_o_n_s_icons.dart';
import '../../widgets/shared/logo.dart';
import 'banners.dart';

class FoodAppBar extends StatelessWidget {
  final bool changeColor;
  final BannersData bannersData;

  const FoodAppBar(
      {Key? key, required this.changeColor, required this.bannersData})
      : super(key: key);
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
                        const Color.fromRGBO(243, 224, 177, 1)
                    ? const Color.fromRGBO(243, 224, 177, 1)
                    : Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        pinned: true,
        actionsIconTheme: IconThemeData(
          color: changeColor
              ? Theme.of(context).primaryColor
              : Theme.of(context).backgroundColor ==
                      const Color.fromRGBO(243, 224, 177, 1)
                  ? const Color.fromRGBO(243, 224, 177, 1)
                  : Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, search),
              icon: const Icon(
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
          title: const Text('',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              )),
          background: BannersSlider(bannersData: bannersData),
        ));
  }
}
