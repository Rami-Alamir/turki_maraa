import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../core/service/firebase_helper.dart';

class SocialMediaIcon extends StatelessWidget {
  final Color? color;
  final String name;
  final IconData icon;
  final String url;
  const SocialMediaIcon(
      {Key? key,
      required this.name,
      required this.icon,
      required this.url,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        FirebaseHelper().pushAnalyticsEvent(name: "social_media", value: name);
        _launchURL(url);
      },
      icon: Icon(
        icon,
        size: 20,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }

  //used to lunch social media
  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (_) {}
  }
}
