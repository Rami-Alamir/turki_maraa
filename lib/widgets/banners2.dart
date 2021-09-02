import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/dots_indicator.dart';

class Banners2 extends StatefulWidget {
  final List<String> imgList;

  const Banners2({required this.imgList});
  @override
  _Banners2State createState() => _Banners2State();
}

class _Banners2State extends State<Banners2> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Stack(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            child: CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: _onPageChanged,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  height: 270,
                  disableCenter: false),
              items: widget.imgList.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: 250,
                      width: SizeConfig.screenWidth,
                      child: Image.network(
                        url.trim(),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 15,
            child: Container(
              width: SizeConfig.screenWidth,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DotsIndicator(
                      accentColor: Colors.white70,
                      count: widget.imgList.length,
                      index: index,
                    ),
                  ],
                ),
              ),
            ),
          )
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
