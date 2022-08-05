import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:math' as math;

class TurkiDrawerFooter extends StatelessWidget {
  final bool ltr;

  const TurkiDrawerFooter({required this.ltr});

  @override
  Widget build(BuildContext context) {
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 30, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _makePhoneCall(
                _addressProvider.isoCountryCode == "AE"
                    ? "tel:+97180050050"
                    : 'tel:+966920002974',
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10.0),
                  child: AutoSizeText(
                    AppLocalizations.of(context)!.tr('contact_support'),
                    style: Theme.of(context).textTheme.headline4,
                    minFontSize: 11,
                    maxFontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(ltr ? math.pi : 0),
            child: Image.asset(
              'assets/images/turki_car.png',
              width: 103,
              height: 75,
            ),
          ),
        ],
      ),
    );
  }

  //used to make calls
  Future<void> _makePhoneCall(String url) async {
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
