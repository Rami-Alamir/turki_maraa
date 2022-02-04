import 'package:flutter/material.dart';
import 'package:new_turki/models/about.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    return Scaffold(
      appBar: PrimaryAppBar(
        title: '',
        back: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              AppLocalizations.of(context)!.tr('about'),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 20,
                    height: 1.5,
                  ),
            ),
          ),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount:
                  _isAr ? AboutData.aboutAr.length : AboutData.aboutEn.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Container(
                      width: SizeConfig.screenWidth! - 30,
                      child: Text(
                        _isAr
                            ? AboutData.aboutAr[index]
                            : AboutData.aboutEn[index],
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                );
              }),
          Container(
            width: SizeConfig.screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    "assets/images/turki_gold.png",
                    colorBlendMode: BlendMode.dstATop,
                    fit: BoxFit.contain,
                    width: 260,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
