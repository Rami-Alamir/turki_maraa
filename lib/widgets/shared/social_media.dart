import 'package:flutter/material.dart';
import 'package:new_turki/utilities/social_icons_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatelessWidget {
  final Color color;

  const SocialMedia({this.color = const Color.fromRGBO(107, 0, 0, 1)});
  @override
  Widget build(BuildContext context) {
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
                url: 'https://www.instagram.com/turki_dbh/',
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
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e.toString());
    }
  }
}