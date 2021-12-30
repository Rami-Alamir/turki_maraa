import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/profile/phone_number.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  @override
  void initState() {
    final _auth = Provider.of<Auth>(context, listen: false);
    _auth.formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(
      context,
    );
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
              PhoneNumber(),
              RoundedRectangleButton(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  title: _auth.start == 0 || _auth.start == 59
                      ? AppLocalizations.of(context)!.tr('next')
                      : _auth.start.toString(),
                  onPressed: () async {
                    if (_auth.start == 59 || _auth.start == 0) {
                      if (_auth.formKey!.currentState!.validate()) {
                        _auth.startTimer();
                        await _auth.sendOTP(context);
                      }
                    }
                  }),
            ],
          ),
        ));
  }
}
