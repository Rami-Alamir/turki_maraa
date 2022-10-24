import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/locals_values.dart';
import '../../../core/utilities/size_config.dart';
import 'phone_login.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  late String _isoCountryCode;

  @override
  void initState() {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    // init country code by location if found or device locals
    final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;
    String localsIsoCountryCode = systemLocales.first.countryCode ?? "SA";
    _isoCountryCode = locationProvider.isoCountryCode != null
        ? locationProvider.isoCountryCode!
        : LocalsValues().getCountryCode(localsIsoCountryCode);
    auth.setIsoCountryCode = _isoCountryCode;
    auth.initCountyCode(GetStrings().getCountryKey(_isoCountryCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const PhoneLogin())),
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: ExactAssetImage(FixedAssets.loginBackground),
              fit: BoxFit.fill,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                        alignment: Alignment.center, // This is needed
                        width: 200,
                        height: 250,
                        child: Image.asset(
                          FixedAssets.logo,
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15.0, 0, 0, 0),
                          child: Text(
                              AppLocalizations.of(context)!
                                  .tr('enter_your_mobile_number'),
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 100),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const PhoneLogin()),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CountryCodePicker(
                                      onChanged: (key) {
                                        auth.initCountyCode(key.toString());
                                      }, // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: _isoCountryCode,
                                      favorite: const ['+966', 'SA'],
                                      countryFilter: const [
                                        'SA',
                                        'AE',
                                        'BH',
                                        'KW',
                                        'QA',
                                        'OM'
                                      ],
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                      // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                                      flagDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    Text(
                                        AppLocalizations.of(context)!.tr(
                                            'enter_your_mobile_number_here'),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                ),
                                const Divider(
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