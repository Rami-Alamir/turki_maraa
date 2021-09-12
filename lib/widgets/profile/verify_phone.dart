import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_turki/screens/profile/username.dart';
import 'package:new_turki/utilities/size_config.dart';
import '../pin_code_fields.dart';
import '../rounded_rectangle_button.dart';

class VerifyPhone extends StatefulWidget {
  final String phone;

  const VerifyPhone({required this.phone});

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  late Timer _timer;
  int _start = 0;
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Container(
              width: SizeConfig.screenWidth,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      'بعدل الرقم',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          ],
          centerTitle: false,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'التحقق من الرقم',
                      style: TextStyle(
                          fontSize: 16, height: 1, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'ستصلك رسالة نصية برمز التحقق على الرقم',
                    style: TextStyle(
                        fontSize: 14, height: 2, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    '+966${widget.phone}',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  PinCodeFields(),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    onPressed: () {
                      if (_start == 0) {
                        _start = 59;
                        _startTimer();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("لم يصلك كود التفعيل؟",
                            style: Theme.of(context).textTheme.headline5),
                        Text(
                            _start == 0
                                ? 'اعادة الارسال'
                                : "00:${_start.toString().padLeft(2, '0')}",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  ),
                  RoundedRectangleButton(
                    title: 'التالي',
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute<bool>(
                              builder: (BuildContext context) => UserName()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
