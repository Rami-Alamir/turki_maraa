import 'package:flutter/material.dart';
import '../../../controllers/auth.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/profile/phone_number.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  PhoneLoginState createState() => PhoneLoginState();
}

class PhoneLoginState extends State<PhoneLogin> {
  @override
  void initState() {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    auth.formKey = GlobalKey<FormState>();
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
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Colors.transparent,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  AppLocalizations.of(context)!
                      .tr('enter_your_mobile_number_to_activate_the_account'),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              PhoneNumber(isoCountryCode: auth.isoCountryCode ?? 'SA'),
              RoundedRectangleButton(
                  width: SizeConfig.screenWidth! - 50,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  title: auth.start == 0 || auth.start == 30
                      ? AppLocalizations.of(context)!.tr('next')
                      : auth.start.toString(),
                  onPressed: () async {
                    if (auth.start == 30 || auth.start == 0) {
                      if (auth.formKey!.currentState!.validate()) {
                        auth.startTimer();
                        await auth.sendOTP(context);
                      }
                    }
                  }),
            ],
          ),
        ));
  }
}
