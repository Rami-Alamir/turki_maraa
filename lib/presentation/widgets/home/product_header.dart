import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../core/constants/app_colors.dart';
import '../shared/dots_indicator.dart';
import '../../../models/images.dart';
import '../../../core/utilities/size_config.dart';

class ProductHeader extends StatefulWidget {
  final List<Images> imgList;
  const ProductHeader({Key? key, required this.imgList}) : super(key: key);

  @override
  ProductHeaderState createState() => ProductHeaderState();
}

class ProductHeaderState extends State<ProductHeader> {
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
            child: SizedBox(
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DotsIndicator(
                    accentColor: AppColors.grey,
                    count: widget.imgList.length,
                    index: index,
                  ),
                ],
              ),
            ),
          ),
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
