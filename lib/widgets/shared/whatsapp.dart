import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../provider/address_provider.dart';

class Whatsapp extends StatelessWidget {
  const Whatsapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(37, 211, 102, 1),
      onPressed: () {
        final _addressProvider =
            Provider.of<AddressProvider>(context, listen: false);
        String phone = _addressProvider.isoCountryCode == "AE"
            ? "+971544055556"
            : '+966500852759';
        String url;
        if (Platform.isIOS)
          url = "whatsapp://wa.me/$phone/?text=${Uri.parse(' ')}";
        else
          url = "whatsapp://send?phone=$phone&text=${Uri.parse(' ')}";
        _launchURL(url);
      },
      child: Image.asset(
        'assets/images/whatsapp.png',
        height: 32,
        width: 32,
      ),
      // child: SvgPicture.asset(
      //   'assets/images/profile_icons/whatsapp-colored.svg',
      //   width: 30,
      // ),
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
    } catch (e) {
      print(e.toString());
    }
  }
}
