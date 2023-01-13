import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utilities/social_icons_icons.dart';
import 'social_media_icon.dart';

class SocialMedia extends StatelessWidget {
  final Color? color;

  const SocialMedia({Key? key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialMediaIcon(
                  name: "instagram",
                  url: locationProvider.isoCountryCode == "AE"
                      ? Constants.instagramUae
                      : Constants.instagramKsa,
                  icon: SocialIcons.instagram,
                  color: color,
                ),
                SocialMediaIcon(
                  name: "snapchat",
                  url: Constants.snapchat,
                  icon: SocialIcons.snapchat,
                  color: color,
                ),
                SocialMediaIcon(
                  name: "twitter",
                  url: Constants.twitter,
                  icon: SocialIcons.twitter,
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
