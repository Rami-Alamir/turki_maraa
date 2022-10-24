import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import '../../../controllers/user_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/profile/delete_row.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../widgets/shared/rectangle_text_field.dart';
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
    if (userProvider.genderController.text.contains("maleString") ||
        userProvider.genderController.text.contains("femaleString")) {
      userProvider.genderController.text =
          AppLocalizations.of(context)!.tr(userProvider.genderController.text);
    }
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
                  _item(
                      title: 'name',
                      textEditingController: userProvider.usernameController),
                  _item(
                      title: 'email',
                      textEditingController: userProvider.emailController),
                  GenderPicker(
                      textEditingController: userProvider.genderController),
                  _item(
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
                  await userProvider.updateUser(context);
                }
              },
            ),
            const DeleteRow(),
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
          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
          child: Text(AppLocalizations.of(context)!.tr(title),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w700, height: 1)),
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
