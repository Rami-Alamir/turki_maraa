import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import '../../../controllers/user_provider.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/show_snack_bar.dart';
import '../../widgets/profile/delete_row.dart';
import '../../widgets/profile/personal_info_item.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../widgets/profile/gender_picker.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  PersonalInformationState createState() => PersonalInformationState();
}

class PersonalInformationState extends State<PersonalInformation> {
  @override
  void initState() {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.initTextController(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PrimaryAppBar(
        title: '',
        back: true,
        isTransparent: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          padding: const EdgeInsets.only(top: 80),
          children: [
            AvatarGlow(
              glowColor: Theme.of(context).primaryColor,
              endRadius: 78.0,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 100),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                    ((userProvider.userData?.data?.name)?.length ?? 0) > 0
                        ? (userProvider.userData?.data?.name ?? " ")
                            .substring(0, 1)
                        : "",
                    style: const TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PersonalInfoItem(
                      title: 'name',
                      textEditingController: userProvider.usernameController),
                  PersonalInfoItem(
                      title: 'email',
                      textEditingController: userProvider.emailController),
                  const GenderPicker(),
                  PersonalInfoItem(
                      title: 'age',
                      textEditingController: userProvider.ageController,
                      textInputType: TextInputType.number),
                ],
              ),
            ),
            RoundedRectangleButton(
              height: 50,
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 0, bottom: 20),
              fontSize: 16,
              title: AppLocalizations.of(context)!.tr('update'),
              onPressed: () async {
                RegExp regex =
                    RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                if (!regex.hasMatch(userProvider.emailController.text) &&
                    userProvider.emailController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    AppLocalizations.of(context)!.tr('enter_valid_email'),
                    textAlign: TextAlign.center,
                  )));
                } else {
                  final int statusCode = await userProvider.updateUser(context);
                  if (!mounted) return;
                  show(context, statusCode);
                }
              },
            ),
            const DeleteRow(),
          ],
        ),
      ),
    );
  }

  void show(BuildContext context, int statusCode) {
    if (statusCode == 1) {
      sl<ShowSnackBar>().show(context, "data_has_been_updated_successfully");
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.of(context, rootNavigator: true).pop();
      sl<ShowSnackBar>().show(
          context,
          statusCode == 200
              ? "data_has_been_updated_successfully"
              : statusCode == 400
                  ? "email_is_used_please_enter_different_email"
                  : "unexpected_error");
    }
  }
}
