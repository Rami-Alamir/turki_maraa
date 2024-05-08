import 'package:flutter/material.dart';
import '../../shared/rectangle_text_field.dart';
import '../../../../core/utilities/app_localizations.dart';

class PersonalInfoItem extends StatelessWidget {
  final String title;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  const PersonalInfoItem(
      {super.key,
      required this.title,
      required this.textEditingController,
      this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
          child: Text(AppLocalizations.of(context)!.tr(title),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
