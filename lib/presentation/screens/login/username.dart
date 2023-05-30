import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/shared/rectangle_text_field.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import '../../../controllers/auth.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/show_snack_bar.dart';

class Username extends StatefulWidget {
  const Username({Key? key}) : super(key: key);

  @override
  UsernameState createState() => UsernameState();
}

class UsernameState extends State<Username> {
  bool logoVisibility = true;
  final GlobalKey<FormState> userNameFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
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
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Form(
                key: userNameFormKey,
                child: RectangleTextField(
                  controller: usernameController,
                  onChanged: (value) {
                    auth.usernameControllerValue = value;
                  },
                  padding: const EdgeInsets.all(20),
                  maxLength: 25,
                  hint: AppLocalizations.of(context)!.tr('name'),
                ),
              ),
              RoundedRectangleButton(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  title: AppLocalizations.of(context)!.tr('next'),
                  onPressed: () async {
                    if (userNameFormKey.currentState!.validate()) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      int statusCode = await auth.addUsername(context);
                      if (context.mounted) {
                        show(context, statusCode);
                      }
                    }
                  }),
            ],
          ),
        ));
  }

  void show(BuildContext context, int statusCode) {
    switch (statusCode) {
      case 1:
        sl<ShowSnackBar>().show(context, "please_enter_your_name");
        break;
      case 200:
        Navigator.of(context).pop();
        Navigator.pushNamedAndRemoveUntil(
            context, app, ModalRoute.withName('/'));
        break;
      default:
        Navigator.of(context).pop();
        sl<ShowSnackBar>().show(context, "unexpected_error");
        break;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }
}
