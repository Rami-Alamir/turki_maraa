import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:provider/provider.dart';
import '../../shared/rectangle_text_field.dart';
import '../../../../controllers/user_provider.dart';
import '../../../../core/utilities/app_localizations.dart';

class GenderPicker extends StatelessWidget {
  const GenderPicker({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    if (userProvider.genderController.text.isEmpty &&
        userProvider.gender != -1) {
      userProvider.initGenderController(context: context);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 15),
          child: Text(AppLocalizations.of(context)!.tr('gender'),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  )),
        ),
        InkWell(
          onTap: () {
            showPicker(context);
          },
          child: RectangleTextField(
            controller: userProvider.genderController,
            enable: false,
          ),
        )
      ],
    );
  }

  void showPicker(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.setGender(0, context);
    Picker(
        headerColor: Theme.of(context).colorScheme.background,
        containerColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.background,
        adapter: PickerDataAdapter(
          data: [
            PickerItem(
                text: Text(
                  AppLocalizations.of(context)!.tr('maleString'),
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(height: 2, fontSize: 16),
                ),
                value: "0"),
            PickerItem(
                text: Text(
                  AppLocalizations.of(context)!.tr('femaleString'),
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(height: 2, fontSize: 16),
                ),
                value: "1")
          ],
        ),
        itemExtent: 35,
        confirmText: AppLocalizations.of(context)!.tr('confirm'),
        confirmTextStyle: Theme.of(context).textTheme.titleSmall,
        cancelText: AppLocalizations.of(context)!.tr('cancel'),
        cancelTextStyle: Theme.of(context).textTheme.titleSmall,
        changeToFirst: false,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(20.0),
        onSelect: (Picker picker, int i, List value) {
          userProvider.setGender(
              int.parse(value.toString().substring(1, 2)), context);
        },
        onConfirm: (Picker picker, List value) {
          userProvider.setGender(
              int.parse(value.toString().substring(1, 2)), context);
        }).showModal(context);
  }
}
