import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/home/category_app_bar.dart';
import 'package:new_turki/widgets/home/category_card.dart';
import 'package:new_turki/widgets/home/not_supported_area.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldStateKey;

  const Home({required this.parentScaffoldStateKey});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _homeProvider.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CategoryAppBar(
          address: "شارع الدرع - حي الياسمين",
          onTap: () {},
          parentScaffoldKey: widget.parentScaffoldStateKey,
        ),
        body: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onRefresh: () async {
            await _homeProvider.getData();
          },
          child: _homeProvider.areaStatus
              ? Padding(
                  padding: const EdgeInsets.only(top: 240.0),
                  child: NotSupportedArea(),
                )
              : ListView(
                  children: [
                    Text(
                        AppLocalizations.of(context)!
                            .tr('what_would_you_want_today'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1),
                    StaggeredGridView.countBuilder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        itemCount: _homeProvider.categoryData.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            index: index + 1,
                            scaleFactor: index % 2 == 0 ? 1.8 : 1.1,
                            image: _homeProvider.categoryData[index].image!,
                            title: AppLocalizations.of(context)!.locale ==
                                    Locale("ar")
                                ? _homeProvider.categoryData[index].titleAr!
                                : _homeProvider.categoryData[index].titleEn!,
                            color: _homeProvider.categoryData[index].color!,
                            color2: _homeProvider.categoryData[index].color2!,
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(
                              1, index % 2 == 0 ? 1.6 : 1.1);
                        }),
                  ],
                ),
        ));
  }
}
