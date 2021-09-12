import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:new_turki/widgets/profile/phone_number.dart';
import 'package:new_turki/widgets/profile/username_field.dart';
import 'package:new_turki/widgets/profile/verify_phone.dart';
import 'package:new_turki/widgets/rounded_rectangle_button.dart';

class UserName extends StatefulWidget {
  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  @override
  Widget build(BuildContext context) {
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
                  'خلنا نتعرف عليك',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              UsernameField(),
              RoundedRectangleButton(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  title: 'التالي',
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());

                    Navigator.pop(context);
                    FocusScope.of(context).requestFocus(FocusNode());

                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
            ],
          ),
        ));
  }
}
