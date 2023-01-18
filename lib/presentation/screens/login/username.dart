import 'package:flutter/material.dart';
import '../../../controllers/auth.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/shared/rectangle_text_field.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class Username extends StatefulWidget {
  const Username({Key? key}) : super(key: key);

  @override
  UsernameState createState() => UsernameState();
}

class UsernameState extends State<Username> {
  bool logoVisibility = true;

  @override
  void initState() {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    auth.usernameController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
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
                controller: auth.usernameController,
                padding: const EdgeInsets.all(20),
                maxLength: 25,
                hint: AppLocalizations.of(context)!.tr('name'),
              ),
              RoundedRectangleButton(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  title: AppLocalizations.of(context)!.tr('next'),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await auth.addUsername(context);
                  }),
            ],
          ),
        ));
  }
}
