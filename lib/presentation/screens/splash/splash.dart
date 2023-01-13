import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controllers/home_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../screens/app/app.dart';
import '../../screens/other/no_internet.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import 'package:provider/provider.dart';
import '../intro/intro.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final LocationProvider location =
        Provider.of<LocationProvider>(context, listen: false);
    final HomeProvider home = Provider.of<HomeProvider>(context, listen: false);
    location.initLatLng();
    home.checkNewVersion();
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
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(105, 30, 24, 1),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(FixedAssets.splash),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
              child: InkWell(
                onTap: navigate,
                child: Text(
                  AppLocalizations.of(context)!.tr('skip'),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // navigate to if new user(intro) else (home)
  void navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intro = prefs.getBool('intro') ?? true;
    bool internetStatus = true;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internetStatus = true;
      }
    } on SocketException catch (_) {
      internetStatus = false;
    }
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => intro
                ? const Intro()
                : internetStatus
                    ? const App()
                    : const NoInternet()),
        (Route<dynamic> route) => false);
  }
}
