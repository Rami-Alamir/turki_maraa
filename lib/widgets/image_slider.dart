import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imgList;
  const ImageSlider({required this.imgList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        options: CarouselOptions(
          disableCenter: true,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          height: 300,
        ),
        items: imgList.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        url.trim(),
                        fit: BoxFit.cover,
                      )),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
