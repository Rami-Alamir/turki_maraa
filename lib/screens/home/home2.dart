import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_turki/models/category_data.dart';
import 'package:new_turki/provider/app_provider.dart';
import 'package:new_turki/screens/app/app.dart';
import 'package:new_turki/widgets/category_app_bar.dart';
import 'package:new_turki/widgets/category_card.dart';
import 'package:provider/provider.dart';

class Home2 extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  const Home2({required this.parentScaffoldKey});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home2> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.context = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<CategoryData> list = [
      CategoryData(
          decorationImage: "assets/images/pngpng-04.png",
          image: "assets/images/i4.png",
          //  'https://storage.googleapis.com/tm-zopsmart-uploads/320/20201031/210840_1-20201031-233123.png',
          // 'https://purepng.com/public/uploads/large/purepng.com-meatmeatanimalfleshchicken-1411527785185fjjh1.png',
          color: Color.fromRGBO(165, 0, 0, 1),
          color2: Theme.of(context).primaryColor,
          title: 'لحوم'),
      CategoryData(
          decorationImage: "assets/images/pngpng-05.png",
          image: "assets/images/i3.png",

          //    'http://assets.stickpng.com/thumbs/585d3bd9cb11b227491c335b.png',
          color: Color.fromRGBO(212, 92, 100, 1),
          color2: Color.fromRGBO(202, 88, 86, 1),
          title: 'دواجن'),
      CategoryData(
          decorationImage: "assets/images/pngpng-03.png",
          image: "assets/images/i5.png",
          //         'https://freepngimg.com/thumb/vegetable/24552-2-vegetable-clipart-thumb.png',
          color: Color.fromRGBO(18, 135, 86, 1),
          color2: Colors.green,
          title: 'خضار وفواكه'),
      CategoryData(
          decorationImage: "assets/images/pngpng-06.png",
          image: "assets/images/amazon.png",
          //    'https://www.sikkimfarms.com/wp-content/uploads/2020/06/whole.png',
          color: Colors.indigoAccent,
          color2: Colors.indigo,
          title: 'بطاقة هدايا'),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CategoryAppBar(
        onTap: _handleMenuButtonPressed,
        parentScaffoldKey: widget.parentScaffoldKey,
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 210),
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
                  scaleFactor: index % 2 == 0 ? 1.8 : 1.1,
                  decorationImage: list[index].decorationImage!,
                  image: list[index].image!,
                  title: list[index].title!,
                  color: list[index].color!,
                  color2: list[index].color2!,
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index % 2 == 0 ? 1.6 : 1.1);
              }),
        ),
      ]),
    );
  }

  void _handleMenuButtonPressed() {
    print('ee');

    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
    print('ee');
  }
}
