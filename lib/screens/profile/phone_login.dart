import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:new_turki/widgets/profile/phone_number.dart';
import 'package:new_turki/widgets/profile/verify_phone.dart';
import 'package:new_turki/widgets/rounded_rectangle_button.dart';

class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('dddd');
    print(_phoneController.text.toString());
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Colors.transparent,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'ادخل رقم جوالك لتفعيل الحساب',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              PhoneNumber(phoneController: _phoneController),
              RoundedRectangleButton(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  title: 'التالي',
                  onPressed: () {
                    print('re');
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute<bool>(
                      builder: (BuildContext context) => VerifyPhone(
                        phone: _phoneController.text.toString(),
                      ),
                    ));
                  }),
            ],
          ),
        ));
  }
}
