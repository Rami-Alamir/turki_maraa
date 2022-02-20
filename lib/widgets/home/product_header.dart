import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:new_turki/models/product.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/dots_indicator.dart';
import 'circle_icon.dart';

class ProductHeader extends StatefulWidget {
  final List<Images> imgList;
  const ProductHeader({required this.imgList});

  @override
  _ProductHeaderState createState() => _ProductHeaderState();
}

class _ProductHeaderState extends State<ProductHeader> {
  bool isFavourite = false;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenWidth,
      constraints:
          BoxConstraints(maxHeight: SizeConfig.screenWidth! > 500 ? 600 : 400),
      color: Colors.transparent,
      width: SizeConfig.screenWidth,
      child: Stack(
        children: [
          Container(
            color: Colors.transparent,
            child: CarouselSlider(
              options: CarouselOptions(
                disableCenter: true,
                viewportFraction: 1,
                onPageChanged: _onPageChanged,
                enableInfiniteScroll: true,
                height: SizeConfig.screenWidth,
              ),
              items: widget.imgList.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(
                      url.imageUrl!.trim(),
                      fit: BoxFit.fill,
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 40,
            child: Container(
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DotsIndicator(
                    accentColor: Colors.grey,
                    count: widget.imgList.length,
                    index: index,
                  ),
                ],
              ),
            ),
          ),
          // Positioned.directional(
          //     start: 20,
          //     top: 52,
          //     textDirection:
          //         AppLocalizations.of(context)!.locale == Locale('ar')
          //             ? TextDirection.rtl
          //             : TextDirection.ltr,
          //     child: CircleIcon(
          //         icon: Icons.arrow_back_ios,
          //         onTap: () => Navigator.pop(context),
          //         padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0, 0, 0))),
        ],
      ),
    );
  }

  _onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      this.index = index;
    });
  }
}
