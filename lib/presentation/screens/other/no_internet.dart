import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  late ConnectivityResult connectivityResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(FixedAssets.noInternet),
          Text(AppLocalizations.of(context)!.tr('no_internet_connection'),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight! / 5),
            child: RoundedRectangleButton(
                title: AppLocalizations.of(context)!.tr('try_again'),
                onPressed: () async {
                  await checkConnectivity();
                  navigate();
                }),
          )
        ],
      ),
    );
  }

  // Check internet connection
  Future<void> checkConnectivity() async {
    try {
      connectivityResult = await Connectivity().checkConnectivity();
    } catch (_) {}
  }

  void navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introStatus = prefs.getBool('intro') ?? true;
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
        introStatus
            ? intro
            : connectivityResult != ConnectivityResult.none
                ? app
                : noInternet,
        (route) => false);
  }
}
