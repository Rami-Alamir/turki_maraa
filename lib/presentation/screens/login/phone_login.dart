import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/login/phone_number.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import '../../../controllers/auth.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/show_snack_bar.dart';
import '../../../core/utilities/size_config.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  PhoneLoginState createState() => PhoneLoginState();
}

class PhoneLoginState extends State<PhoneLogin> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController phoneController;

  @override
  void initState() {
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  AppLocalizations.of(context)!
                      .tr('enter_your_mobile_number_to_activate_the_account'),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              PhoneNumber(formKey: formKey, phoneController: phoneController),
              Consumer<Auth>(builder: (_, auth, __) {
                return RoundedRectangleButton(
                    width: SizeConfig.screenWidth! - 50,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    title: auth.start == 0 || auth.start == 30
                        ? AppLocalizations.of(context)!.tr('next')
                        : auth.start.toString(),
                    onPressed: () async {
                      if (auth.start == 30 || auth.start == 0) {
                        if (formKey.currentState!.validate()) {
                          auth.startTimer();
                          final int statusCode = await auth.sendOTP(context);
                          if (context.mounted) show(context, statusCode);
                        }
                      }
                    });
              }),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void show(BuildContext context, int statusCode) {
    Navigator.of(context).pop();
    if (statusCode == 200) {
      Navigator.pushNamed(context, verifyPhone);
    } else {
      sl<ShowSnackBar>().show(
          context,
          statusCode == 401
              ? "sorry_you_can_not_log_in_after_deleting_your_account"
              : "unexpected_error");
    }
  }
}
