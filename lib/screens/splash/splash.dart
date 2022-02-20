import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/screens/app/app.dart';
import 'package:new_turki/screens/intro/intro.dart';
import 'package:new_turki/screens/other/no_internet.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final _home = Provider.of<HomeProvider>(context, listen: false);
    _home.getHomePageData(true);
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
      backgroundColor: Color.fromRGBO(105, 30, 24, 1),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash.gif"),
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
                  style: TextStyle(color: Colors.white, fontSize: 18),
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
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool _intro = _prefs.getBool('intro') ?? true;
    bool _internetStatus = true;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _internetStatus = true;
      }
    } on SocketException catch (_) {
      _internetStatus = false;
    }
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => _intro
                ? Intro()
                : _internetStatus
                    ? App()
                    : NoInternet()),
        (Route<dynamic> route) => false);
  }
}
