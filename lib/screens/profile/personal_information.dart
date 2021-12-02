import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/rectangle_text_field.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    return Scaffold(
      appBar: PrimaryAppBar(title: '', back: true),
      body: ListView(
        children: [
          AvatarGlow(
            glowColor: Theme.of(context).primaryColor,
            endRadius: 78.0,
            duration: Duration(milliseconds: 2000),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: Duration(milliseconds: 100),
            child: Container(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(_auth.user.name!.substring(0, 1),
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(AppLocalizations.of(context)!.tr('name'),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                RectangleTextField(
                  controller: _auth.usernameController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(AppLocalizations.of(context)!.tr('email'),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                RectangleTextField(
                  controller: _auth.emailController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(AppLocalizations.of(context)!.tr('nationality'),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                RectangleTextField(
                  controller: _auth.nationalityController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(AppLocalizations.of(context)!.tr('age'),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                RectangleTextField(
                  controller: _auth.ageController,
                ),
              ],
            ),
          ),
          RoundedRectangleButton(
            height: 50,
            padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
            fontSize: 16,
            title: AppLocalizations.of(context)!.tr('update'),
            onPressed: () async {
              await _auth.updateUser(context);
            },
          )
        ],
      ),
    );
  }
}
