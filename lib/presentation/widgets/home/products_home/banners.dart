import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../shared/dots_indicator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/utilities/size_config.dart';
import '../../../../models/banners_data.dart';

class BannersSlider extends StatefulWidget {
  final BannersData bannersData;

  const BannersSlider({Key? key, required this.bannersData}) : super(key: key);
  @override
  BannersState createState() => BannersState();
}

class BannersState extends State<BannersSlider> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          SizedBox(
            width: SizeConfig.screenWidth,
            child: CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: _onPageChanged,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  height: 270,
                  disableCenter: false),
              items: widget.bannersData.data!.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        try {
                          if (item.type == "2") {
                            Navigator.pushNamed(context, productDetails,
                                arguments: <String, dynamic>{
                                  "id": item.productId,
                                  "categoryId": 0
                                });
                          } else if (item.type == "1") {
                            _launchURL(item.redirectUrl.toString());
                          }
                        } catch (_) {}
                      },
                      child: SizedBox(
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
            child: SizedBox(
              width: SizeConfig.screenWidth,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DotsIndicator(
                      accentColor: AppColors.white70,
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
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (_) {}
  }

  _onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      this.index = index;
    });
  }
}
