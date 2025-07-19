import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/constants/app_colors.dart';

class RectangleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function? validated;
  final Function? onChanged;
  final EdgeInsetsDirectional contentPadding;
  final bool? emailValidate;
  final bool? obscureText;
  final bool? enable;
  final EdgeInsets? padding;
  final int maxLength;
  final int maxLines;
  final double? customWidth;
  final bool? white;

  const RectangleTextField({
    super.key,
    required this.controller,
    this.hint,
    this.focusNode,
    this.nextFocusNode,
    this.contentPadding = const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
    this.white,
    this.enable = true,
    this.textInputType,
    this.onChanged,
    this.validated,
    this.emailValidate,
    this.maxLength = 120,
    this.maxLines = 1,
    this.textInputAction,
    this.obscureText,
    this.padding,
    this.customWidth,
  });

  @override
  Widget build(BuildContext context) {
    double width = SizeConfig.screenWidth!;
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Container(
        color: Colors.transparent,
        width: customWidth ?? SizeConfig.screenWidth,
        child: TextFormField(
          enabled: enable,
          textAlignVertical: TextAlignVertical.center,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: textInputType ?? TextInputType.text,
          keyboardAppearance: Brightness.dark,
          focusNode: focusNode,
          obscureText: obscureText ?? false,
          textAlign: TextAlign.start,
          cursorColor: Theme.of(context).colorScheme.primary,
          controller: controller,
          onChanged: (value) {
            if (onChanged != null) onChanged!(value);
          },
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: width > 600 ? 18 : 14,
            fontWeight: FontWeight.normal,
          ),
          textInputAction: textInputAction ?? TextInputAction.done,
          decoration: InputDecoration(
            counterText: "",
            fillColor: white != null ? Colors.white : Colors.transparent,
            filled: true,
            contentPadding: contentPadding,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
            errorStyle: const TextStyle(fontSize: 12),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withValues(alpha: 0.35),
                width: 0.35,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withValues(alpha: 0.35),
                width: 0.35,
              ),
            ),
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: width > 600 ? 14 : 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          validator: (value) {
            if (emailValidate ?? false) {
              Pattern pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = RegExp(pattern.toString());
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
