import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/locals_values.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/login/phone_number.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  String? _isoCountryCode;

  @override
  void initState() {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    auth.formKey = GlobalKey<FormState>();
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    // init country code by location if found or device locals
    final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;
    String localsIsoCountryCode = systemLocales.first.countryCode ?? "SA";
    _isoCountryCode = locationProvider.isoCountryCode != null
        ? locationProvider.isoCountryCode!
        : sl<LocalsValues>().getCountryCode(localsIsoCountryCode);
    auth.setIsoCountryCode = _isoCountryCode ?? "SA";
    auth.setDialCode = sl<GetStrings>().getCountryKey(_isoCountryCode ?? "SA");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: GestureDetector(
          onTap: () => Navigator.pushNamed(context, phoneLogin),
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
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 40.0),
                      width: 200,
                      height: 250,
                      child: Image.asset(
                        FixedAssets.logo,
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
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
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 100),
                          child: InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, phoneLogin),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PhoneNumber(
                                    isWhite: true,
                                    isoCountryCode: auth.isoCountryCode!),
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
