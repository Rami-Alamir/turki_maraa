import 'dart:io';
import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../../../controllers/app_language.dart';
import '../../../controllers/app_provider.dart';
import '../../../controllers/home_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/service/adjust_helper.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/service/service_locator.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  Timer? _timer;
  late ConnectivityResult connectivityResult;
  bool internetStatus = true;
  @override
  void initState() {
    super.initState();
    initAdjustSDK();
    checkConnectivity();
    context.read<LocationProvider>().initLatLng(
      context.read<AppLanguage>().language,
    );
    context.read<AppProvider>().getData();
    context.read<HomeProvider>().getHomePageData(notify: false);
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
      backgroundColor: AppColors.primaryColor,
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
                    style: const TextStyle(color: AppColors.gold, fontSize: 18),
                  ),
                ),
              ),
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
          child: Image.asset(
            FixedAssets.logoGif,
            height: 300,
            width: 300,
            fit: BoxFit.cover,
          ),
          // Lottie.asset(FixedAssets.logoLottie,
          //     height: 450, width: 450, fit: BoxFit.contain),
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
          : internetStatus
          ? context.read<AppProvider>().isVideoSean
                ? app
                : videoSplash
          : noInternet,
      (route) => false,
    );
  }

  // Check internet connection
  Future<List<ConnectivityResult>> checkConnectivity() async {
    List<ConnectivityResult> connectivityResult = [];
    try {
      connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        connectivityResult = await Connectivity().checkConnectivity();
      }
      internetStatus = (!connectivityResult.contains(ConnectivityResult.none));
    } catch (_) {}
    return connectivityResult;
  }

  void initAdjustSDK() async {
    if (Platform.isIOS) {
      await Adjust.requestAppTrackingAuthorization();
    }
    final AdjustConfig config = AdjustConfig(
      Constants.adjustToken,
      AdjustEnvironment.production,
    );
    config.logLevel = AdjustLogLevel.verbose;
    Adjust.initSdk(config);
    AdjustHelper().pushAdjustEvents(eventToken: Constants.adjustAppOpen);
  }
}
