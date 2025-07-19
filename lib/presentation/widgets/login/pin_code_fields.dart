import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../controllers/auth.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/show_snack_bar.dart';

class PinCodeFields extends StatefulWidget {
  const PinCodeFields({super.key});

  @override
  State<PinCodeFields> createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (_, auth, _) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Center(
              child: SizedBox(
                width: 250,
                child: PinCodeTextField(
                  appContext: context,
                  controller: otpController,
                  pastedTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: false,
                  obscuringCharacter: '*',
                  obscuringWidget: Image.asset(
                    FixedAssets.logo,
                    width: 35,
                    height: 35,
                  ),
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 4) {
                      return '';
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    errorBorderColor: Theme.of(context).primaryColor,
                    inactiveColor: Theme.of(
                      context,
                    ).colorScheme.secondaryContainer,
                    activeColor: Theme.of(context).colorScheme.primary,
                    inactiveFillColor: Theme.of(context).colorScheme.onSurface,
                    selectedFillColor: Theme.of(context).colorScheme.onSurface,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    disabledColor: Theme.of(context).colorScheme.onSurface,
                    activeFillColor: AppColors.white,
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: AppColors.black12,
                      blurRadius: 0,
                    ),
                  ],
                  onCompleted: (v) async {
                    int statusCode = await auth.verifyOTP(context);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      if (statusCode == 200) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          auth.isNewUser ? username : app,
                          ModalRoute.withName('/'),
                        );
                      } else {
                        sl<ShowSnackBar>().show(
                          context,
                          statusCode == 400
                              ? 'invalid_activation_code'
                              : 'unexpected_error',
                        );
                      }
                    }
                  },
                  onChanged: (value) {
                    auth.otpControllerValue = value;
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
}
