import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: ExactAssetImage('assets/images/t1.gif'),
              fit: BoxFit.fitHeight,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Container(
                        alignment: Alignment.center, // This is needed
                        width: 200,
                        height: 150,
                        child: Image.asset(
                          'assets/images/turki.png',
                          width: 200,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text('نتوصى فيك',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8.0, 0, 0, 0),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .tr('enter_your_mobile_number'),
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 100),
                          child: InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, "/PhoneLogin"),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CountryCodePicker(
                                      onChanged: print,
                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: 'SA',
                                      favorite: ['+966', 'SA'],
                                      countryFilter: [
                                        'SA',
                                        'AE',
                                        'BH',
                                        'KW',
                                        'QA'
                                      ],
                                      textStyle: TextStyle(color: Colors.white),
                                      // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                                      flagDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    Text(
                                        AppLocalizations.of(context)!.tr(
                                            'enter_your_mobile_number_here'),
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                Divider(
                                  indent: 25,
                                  endIndent: 20,
                                  thickness: 3,
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                )
              ],
            ),
          ),
        ));
  }
}
