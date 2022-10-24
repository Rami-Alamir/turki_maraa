import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/service/firebase_helper.dart';

class Whatsapp extends StatelessWidget {
  const Whatsapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromRGBO(37, 211, 102, 1),
      onPressed: () {
        final LocationProvider locationProvider =
            Provider.of<LocationProvider>(context, listen: false);
        FirebaseHelper().pushAnalyticsEvent(name: "contact_via_whatsApp");
        String phone = locationProvider.isoCountryCode == "AE"
            ? KConstants.uaeWhats
            : KConstants.ksaWhats;
        String url;
        if (Platform.isIOS) {
          url = "whatsapp://wa.me/$phone/?text=${Uri.parse(' ')}";
        } else {
          url = "whatsapp://send?phone=$phone&text=${Uri.parse(' ')}";
        }
        _launchURL(url);
      },
      child: Image.asset(
        FixedAssets.whatsapp2,
        height: 32,
        width: 32,
      ),
    );
  }

  //used to make calls, whatsapp
  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (_) {}
  }
}