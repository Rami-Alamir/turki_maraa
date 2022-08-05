import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/utilities/social_icons_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialMedia extends StatelessWidget {
  final Color color;

  const SocialMedia({this.color = const Color.fromRGBO(90, 4, 9, 1.0)});
  @override
  Widget build(BuildContext context) {
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _socialIcon(
                context: context,
                url: _addressProvider.isoCountryCode == "AE"
                    ? "https://www.instagram.com/turki.dbh/"
                    : 'https://www.instagram.com/turki_dbh/',
                icon: SocialIcons.instagram_2,
              ),
              _socialIcon(
                context: context,
                url: 'https://www.snapchat.com/add/TORKI666008',
                icon: SocialIcons.snapchat,
              ),
              _socialIcon(
                context: context,
                url: 'https://twitter.com/turki_DBH',
                icon: SocialIcons.twitter,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _socialIcon(
      {required BuildContext context,
      required IconData icon,
      required String url}) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: () {
        _launchURL(url);
      },
      icon: Icon(
        icon,
        size: 20,
        color: color,
      ),
    );
  }

  //used to lunch social media
  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
