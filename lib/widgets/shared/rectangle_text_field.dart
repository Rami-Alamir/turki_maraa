import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class RectangleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final validated;
  final bool? emailValidate;
  final bool? obscureText;
  final EdgeInsets? padding;
  final double? customWidth;
  final bool? white;

  const RectangleTextField({
    required this.controller,
    this.hint,
    this.focusNode,
    this.nextFocusNode,
    this.white,
    this.textInputType,
    this.validated,
    this.emailValidate,
    this.textInputAction,
    this.obscureText,
    this.padding,
    this.customWidth,
  });

  @override
  Widget build(BuildContext context) {
    double width = SizeConfig.screenWidth!;
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Container(
        width: customWidth ?? (width * 0.9),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          maxLines: 1,
          keyboardType: textInputType ?? TextInputType.text,
          keyboardAppearance: Brightness.dark,
          focusNode: focusNode,
          obscureText: obscureText ?? false,
          textAlign: TextAlign.start,
          cursorColor: Theme.of(context).primaryColor,
          controller: controller,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(fontSize: width > 600 ? 20 : 16),
          textInputAction: textInputAction ?? TextInputAction.done,
          decoration: InputDecoration(
              fillColor: white != null ? Colors.white : Colors.transparent,
              filled: true,
              contentPadding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              errorStyle: TextStyle(fontSize: 12),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38, width: 0.35)),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38, width: 0.35),
              ),
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontSize: width > 600 ? 18 : 14,
                  fontWeight: FontWeight.normal)),
          validator: (value) {
            if (emailValidate ?? false) {
              Pattern pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = new RegExp(pattern.toString());
              if (!regex.hasMatch(value!.trim())) {
                return AppLocalizations.of(context)!.tr('enter_valid_email');
              }
            }
            return null;
          },
        ),
      ),
    );
  }
}
