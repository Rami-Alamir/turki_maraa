import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class PinCodeFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    TextEditingController otpController = TextEditingController();

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
                  'assets/images/turki_icon.png',
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
                  inactiveColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveFillColor: Theme.of(context).backgroundColor,
                  selectedFillColor: Theme.of(context).backgroundColor,
                  selectedColor: Theme.of(context).primaryColor,
                  disabledColor: Theme.of(context).backgroundColor,
                  activeFillColor: Colors.white,
                ),
                cursorColor: Theme.of(context).primaryColor,
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 0,
                  )
                ],
                onCompleted: (v) async {
                  await _auth.verifyOTP(context);
                },
                onChanged: (value) {
                  _auth.otpController.text = value;
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
            ),
          )),
    );
  }
}
