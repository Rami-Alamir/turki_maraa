import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/profile/pin_code_fields.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class VerifyPhone extends StatefulWidget {
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  @override
  void initState() {
    final _auth = Provider.of<Auth>(context, listen: false);
    _auth.otpController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Container(
              width: SizeConfig.screenWidth,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
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
        body: Container(
          child: GestureDetector(
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
                      style: TextStyle(
                          fontSize: 16, height: 1, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.tr(
                            'you_will_receive_a_text_message_with_a_verification_code_on_the_number') +
                        " ",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 14, height: 2, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    _auth.userPhone,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 14, height: 2, fontWeight: FontWeight.bold),
                  ),
                  PinCodeFields(),
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
                            if (_auth.start == 59 || _auth.start == 0) {
                              _auth.startTimer();
                              await _auth.sendOTP(context);
                            }
                          },
                          child: Text(
                              _auth.start == 0
                                  ? ' ${AppLocalizations.of(context)!.tr('resend')}'
                                  : "00:${_auth.start.toString().padLeft(2, '0')}",
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
                      title: AppLocalizations.of(context)!.tr('next'),
                      onPressed: () async {
                        await _auth.verifyOTP(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
