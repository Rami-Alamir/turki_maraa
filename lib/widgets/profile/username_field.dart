import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController keyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textField(context, SizeConfig.screenWidth! * 0.85,
                    keyController, 'ادخل اسمك', true)
              ],
            ),
            Divider(
              color: Colors.black.withOpacity(0.5),
              indent: 10,
              endIndent: 15,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _textField(BuildContext context, double width,
      TextEditingController controller, String hint, bool enabled) {
    return Container(
      width: width,
      child: TextField(
        enabled: enabled,
        autofocus: true,
        cursorColor: Theme.of(context).primaryColor,
        controller: controller,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
        decoration: InputDecoration(
          hintText: 'ادخل اسمك',
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0)),
          focusColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
