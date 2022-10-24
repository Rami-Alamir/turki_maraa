import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import '../../widgets/shared/rectangle_text_field.dart';
import '../../../controllers/user_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import 'package:provider/provider.dart';

class GenderPicker extends StatelessWidget {
  final TextEditingController textEditingController;

  const GenderPicker({Key? key, required this.textEditingController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 15),
          child: Text(AppLocalizations.of(context)!.tr('gender'),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  )),
        ),
        InkWell(
          onTap: () {
            showPicker(context);
          },
          child: RectangleTextField(
            controller: textEditingController,
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
        headerColor: Theme.of(context).backgroundColor,
        containerColor: Theme.of(context).backgroundColor,
        backgroundColor: Theme.of(context).backgroundColor,
        adapter: PickerDataAdapter(
          data: [
            PickerItem(
                text: Text(
                  AppLocalizations.of(context)!.tr('maleString'),
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(height: 2, fontSize: 16),
                ),
                value: "0"),
            PickerItem(
                text: Text(
                  AppLocalizations.of(context)!.tr('femaleString'),
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(height: 2, fontSize: 16),
                ),
                value: "1")
          ],
        ),
        itemExtent: 35,
        confirmText: AppLocalizations.of(context)!.tr('confirm'),
        confirmTextStyle: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
        cancelText: AppLocalizations.of(context)!.tr('cancel'),
        cancelTextStyle: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
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
