import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/dots_indicator.dart';

class ImageSlider2 extends StatefulWidget {
  final List<String> imgList;
  const ImageSlider2({required this.imgList});

  @override
  _ImageSlider2State createState() => _ImageSlider2State();
}

class _ImageSlider2State extends State<ImageSlider2> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).accentColor.withOpacity(0.9),
            child: CarouselSlider(
              options: CarouselOptions(
                disableCenter: true,
                viewportFraction: 1,
                onPageChanged: _onPageChanged,
                enableInfiniteScroll: true,
                height: 362,
              ),
              items: widget.imgList.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(
                      url.trim(),
                      fit: BoxFit.cover,
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
          Positioned(
              left: 20,
              bottom: 2,
              child: Container(
                width: 51,
                height: 51,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .textTheme
                          .headline4!
                          .color!
                          .withOpacity(0.3),
                      blurRadius: 44,
                      offset: Offset(4, 8), // Shadow position
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: Theme.of(context).accentColor, // inner circle color
                ),
                child: Icon(Icons.favorite_border,
                    color: Theme.of(context).primaryColor),
              )),
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
