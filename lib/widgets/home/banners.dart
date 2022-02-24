import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/models/banners_data.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/dots_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class BannersSlider extends StatefulWidget {
  final BannersData bannersData;

  const BannersSlider({required this.bannersData});
  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<BannersSlider> {
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
              items: widget.bannersData.data!.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        // if (item.type != null)
                        //   Navigator.pushNamed(context, item.redirectMobileUrl!,
                        //       arguments: item.productId);
                        // else
                        //   _launchURL(item.redirectUrl.toString());
                      },
                      child: Container(
                        height: 250,
                        width: SizeConfig.screenWidth,
                        child: Image.network(
                          item.url!.trim(),
                          fit: BoxFit.fill,
                        ),
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
                      count: widget.bannersData.data!.length,
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

//used to lunch url
  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      this.index = index;
    });
  }
}
