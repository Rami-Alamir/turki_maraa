import 'package:flutter/material.dart';
import '../../../controllers/auth.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/show_snack_bar.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/login/pin_code_fields.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({Key? key}) : super(key: key);

  @override
  VerifyPhoneState createState() => VerifyPhoneState();
}

class VerifyPhoneState extends State<VerifyPhone> {
  @override
  void initState() {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    auth.otpController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            SizedBox(
              width: SizeConfig.screenWidth,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      AppLocalizations.of(context)!.tr('change_number'),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          ],
          centerTitle: false,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Colors.transparent,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalizations.of(context)!.tr('verify_the_number'),
                    style: const TextStyle(
                        fontSize: 16, height: 1, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "${AppLocalizations.of(context)!.tr('you_will_receive_a_text_message_with_a_verification_code_on_the_number')} ",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 14, height: 2, fontWeight: FontWeight.normal),
                ),
                Text(
                  auth.userPhone,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 14, height: 2, fontWeight: FontWeight.bold),
                ),
                const PinCodeFields(),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          AppLocalizations.of(context)!
                              .tr('did_you_not_receive_the_activation_code'),
                          style: Theme.of(context).textTheme.headline5),
                      InkWell(
                        onTap: () async {
                          if (auth.start == 30 || auth.start == 0) {
                            auth.startTimer();
                            final int statusCode =
                                await auth.sendOTP(context, navigate: false);
                            if (!mounted) return;
                            Navigator.of(context).pop();
                            if (statusCode != 200) {
                              sl<ShowSnackBar>().show(
                                  context,
                                  statusCode == 401
                                      ? "sorry_you_can_not_log_in_after_deleting_your_account"
                                      : "unexpected_error");
                            }
                          }
                        },
                        splashColor: Colors.transparent,
                        child: Text(
                            auth.start == 0
                                ? ' ${AppLocalizations.of(context)!.tr('resend')}'
                                : "00:${auth.start.toString().padLeft(2, '0')}",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: RoundedRectangleButton(
                    width: SizeConfig.screenWidth! - 40,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    title: AppLocalizations.of(context)!.tr('next'),
                    onPressed: () async {
                      int statusCode = await auth.verifyOTP(context);
                      if (!mounted) return;
                      show(context, statusCode, auth.isNewUser);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void show(BuildContext context, int statusCode, bool isNewUser) {
    switch (statusCode) {
      case 1:
        sl<ShowSnackBar>().show(context, "please_enter_otp");
        break;
      case 200:
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.of(context).pop();
        Navigator.pushNamedAndRemoveUntil(
            context, isNewUser ? username : app, ModalRoute.withName('/'));
        break;
      case 400:
        Navigator.of(context).pop();
        sl<ShowSnackBar>().show(context, "invalid_activation_code");
        break;
      default:
        Navigator.of(context).pop();
        sl<ShowSnackBar>().show(context, "unexpected_error");
        break;
    }
  }
}
