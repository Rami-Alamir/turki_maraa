import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/dots_indicator.dart';

class Banners extends StatefulWidget {
  final List<String> imgList;

  const Banners({required this.imgList});
  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Visibility(
        visible: widget.imgList.length > 0,
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
                    height: SizeConfig.screenWidth! / 2.1,
                    disableCenter: true),
                items: widget.imgList.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: SizeConfig.screenHeight! / 2.7,
                          width: SizeConfig.screenWidth,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/placeholder.png',
                                image: url.trim(),
                                fit: BoxFit.cover,
                              )),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Positioned(
              bottom: 20,
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
      ),
    );
  }

  _onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      this.index = index;
    });
  }
}
