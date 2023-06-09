import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import '../../../controllers/app_provider.dart';
import '../../../controllers/auth.dart';
import '../../../controllers/home_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(FixedAssets.noInternet),
          Text(AppLocalizations.of(context)!.tr('no_internet_connection'),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleSmall),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight! / 5),
            child: RoundedRectangleButton(
                title: AppLocalizations.of(context)!.tr('try_again'),
                onPressed: () async {
                  ConnectivityResult connectivityResult =
                      await checkConnectivity();
                  if (connectivityResult != ConnectivityResult.none) {
                    if (context.mounted) {
                      await navigate(context);
                    }
                  }
                }),
          )
        ],
      ),
    );
  }

  // Check internet connection
  Future<ConnectivityResult> checkConnectivity() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await Connectivity().checkConnectivity();
    } catch (_) {}
    return connectivityResult;
  }

  Future<void> navigate(BuildContext context) async {
    final LocationProvider location =
        Provider.of<LocationProvider>(context, listen: false);
    final HomeProvider home = Provider.of<HomeProvider>(context, listen: false);
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    await location.initLatLng();
    if (context.mounted) {
      final Auth auth = Provider.of<Auth>(context, listen: false);
      FlutterSecureStorage localStorage = const FlutterSecureStorage();
      String accessToken = await localStorage.read(key: 'accessToken') ?? "";
      if (context.mounted) auth.getUserData(context, accessToken);
    }
    appProvider.getData();
    home.getHomePageData(notify: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introStatus = prefs.getBool('intro') ?? true;
    if (context.mounted) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(introStatus ? intro : app, (route) => false);
    }
  }
}
