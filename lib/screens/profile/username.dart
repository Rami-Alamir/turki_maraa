import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/screens/app/app.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/rectangle_text_field.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class Username extends StatefulWidget {
  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  @override
  void initState() {
    final _auth = Provider.of<Auth>(context, listen: false);
    _auth.usernameController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);

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
                  AppLocalizations.of(context)!.tr('lets_get_to_know_you'),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              RectangleTextField(
                controller: _auth.usernameController,
                padding: EdgeInsets.all(20),
                maxLength: 30,
                hint: AppLocalizations.of(context)!.tr('name'),
              ),
              RoundedRectangleButton(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  title: AppLocalizations.of(context)!.tr('next'),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await _auth.updateUser(context);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => App(index: 4)),
                        ModalRoute.withName('/'));
                  }),
            ],
          ),
        ));
  }
}
