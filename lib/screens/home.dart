import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_turki/models/category_data.dart';
import '../widgets/category_card.dart';
import '../widgets/accent_app_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final List<CategoryData> list = [
      CategoryData(
          decorationImage: "assets/images/pngpng-06.png",
          image:
              'https://choicefoodsthailand.com/sites/default/files/2018-10/pork_05_freshporkcut.png',
          color: Color.fromRGBO(132, 15, 15, 1),
          color2: Color.fromRGBO(132, 15, 15, 1),
          title: 'لحوم'),
      CategoryData(
          decorationImage: "assets/images/pngpng-05.png",
          image:
              'http://assets.stickpng.com/thumbs/585d3bd9cb11b227491c335b.png',
          color: Color.fromRGBO(212, 92, 86, 1),
          color2: Color.fromRGBO(212, 92, 86, 1),
          title: 'أسماك'),
      CategoryData(
          decorationImage: "assets/images/pngpng-04.png",
          image:
              'https://www.pngkit.com/png/full/50-503419_chicken-drumsticks-chicken-meat-cut-png.png',
          color: Color.fromRGBO(150, 22, 22, 1),
          color2: Color.fromRGBO(150, 22, 22, 1),
          title: 'دواجن'),
      CategoryData(
          decorationImage: "assets/images/pngpng-03.png",
          image:
              'https://www.pngall.com/wp-content/uploads/5/Diet-PNG-Transparent-HD-Photo.png',
          color: Color.fromRGBO(212, 92, 86, 1),
          color2: Color.fromRGBO(212, 92, 86, 1),
          title: 'خضار وفواكه'),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AccentAppBar(),
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 260),
          ),
        ),
        SliverToBoxAdapter(
          child: Text('وش ودك تطلب اليوم؟',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1),
        ),
        SliverToBoxAdapter(
          child: StaggeredGridView.countBuilder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              itemCount: 4,
              itemBuilder: (context, index) {
                return CategoryCard(
                  decorationImage: list[index].decorationImage!,
                  scaleFactor: index % 2 == 0 ? 1.1 : 1.15,
                  image: list[index].image!,
                  title: list[index].title!,
                  color: list[index].color!,
                  color2: list[index].color2!,
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index % 2 == 0 ? 1.8 : 1.2);
              }),
        ),
      ]),
    );
  }
}
