import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/rectangle_text_field.dart';
import 'package:new_turki/widgets/profile/rounded_picker_button.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/profile/delete_row.dart';

class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  void initState() {
    final _auth = Provider.of<Auth>(context, listen: false);
    _auth.initTextController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    if (_auth.genderController.text.contains("maleString") ||
        _auth.genderController.text.contains("femaleString"))
      _auth.genderController.text =
          AppLocalizations.of(context)!.tr(_auth.genderController.text);
    return Scaffold(
      appBar: PrimaryAppBar(title: '', back: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          children: [
            AvatarGlow(
              glowColor: Theme.of(context).primaryColor,
              endRadius: 78.0,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 100),
              child: Container(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                      ((_auth.userData?.data?.name)?.length ?? 0) > 0
                          ? (_auth.userData?.data?.name ?? " ").substring(0, 1)
                          : "",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _item(
                      title: 'name',
                      textEditingController: _auth.usernameController),
                  _item(
                      title: 'email',
                      textEditingController: _auth.emailController),
                  RoundedPickerButton(
                      textEditingController: _auth.genderController),
                  _item(
                      title: 'age',
                      textEditingController: _auth.ageController,
                      textInputType: TextInputType.number),
                ],
              ),
            ),
            RoundedRectangleButton(
              height: 50,
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 10, bottom: 20),
              fontSize: 16,
              title: AppLocalizations.of(context)!.tr('update'),
              onPressed: () async {
                RegExp regex = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                if (!regex.hasMatch(_auth.emailController.text) &&
                    _auth.emailController.text.length > 0)
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    AppLocalizations.of(context)!.tr('enter_valid_email'),
                    textAlign: TextAlign.center,
                  )));
                else
                  await _auth.updateUser(context);
              },
            ),
            DeleteRow()
          ],
        ),
      ),
    );
  }

  Widget _item(
      {required String title,
      required TextEditingController textEditingController,
      TextInputType textInputType = TextInputType.text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(AppLocalizations.of(context)!.tr(title),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  )),
        ),
        RectangleTextField(
          controller: textEditingController,
          maxLength: 30,
          textInputType: textInputType,
        ),
      ],
    );
  }
}
