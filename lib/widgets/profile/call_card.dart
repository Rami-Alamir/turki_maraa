import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../provider/address_provider.dart';
import '../../utilities/app_localizations.dart';
import '../../utilities/size_config.dart';
import '../shared/main_card.dart';

class CallCard extends StatelessWidget {
  const CallCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
        height: 40,
        width: SizeConfig.screenWidth!,
        padding: EdgeInsets.only(bottom: 1, right: 7, left: 7),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              final _addressProvider =
                  Provider.of<AddressProvider>(context, listen: false);
              _launchURL(_addressProvider.isoCountryCode == "AE"
                  ? "tel:+97180050050"
                  : 'tel:+966920002974');
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SvgPicture.asset(
                          'assets/images/profile_icons/customer-support.svg',
                        ),
                      ),
                      Text(AppLocalizations.of(context)!.tr('contact_support'),
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

//used to make calls, whatsapp
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
