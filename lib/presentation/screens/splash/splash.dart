import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controllers/app_provider.dart';
import '../../../controllers/home_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/service/service_locator.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  Timer? _timer;
  late ConnectivityResult connectivityResult;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    final LocationProvider location =
        Provider.of<LocationProvider>(context, listen: false);
    final HomeProvider home = Provider.of<HomeProvider>(context, listen: false);
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    location.initLatLng();
    appProvider.checkNewVersion();
    home.getHomePageData(notify: false);
    _timer = Timer(const Duration(milliseconds: 3000), () {
      navigate();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    sl<SizeConfig>().init(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(105, 30, 24, 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                child: InkWell(
                  onTap: navigate,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text(
                    AppLocalizations.of(context)!.tr('skip'),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(FixedAssets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Lottie.asset(FixedAssets.logoLottie,
              height: 450, width: 450, fit: BoxFit.contain),
        ),
      ),
    );
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

  // Check internet connection
  Future<void> checkConnectivity() async {
    try {
      connectivityResult = await Connectivity().checkConnectivity();
    } catch (_) {}
  }
}
