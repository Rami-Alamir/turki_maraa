import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PinCodeFields extends StatefulWidget {
  @override
  _PinCodeFieldsState createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();

  final FocusNode _inputFocusNode1 = new FocusNode();
  final FocusNode _inputFocusNode2 = new FocusNode();
  final FocusNode _inputFocusNode3 = new FocusNode();
  final FocusNode _inputFocusNode4 = new FocusNode();
  final FocusNode _inputFocusNode5 = new FocusNode();
  final FocusNode _inputFocusNode6 = new FocusNode();
  final FocusNode _inputFocusNode7 = new FocusNode();

  @override
  void dispose() {
    _inputFocusNode1.dispose();
    _inputFocusNode2.dispose();
    _inputFocusNode3.dispose();
    _inputFocusNode4.dispose();
    _inputFocusNode5.dispose();
    _inputFocusNode6.dispose();
    _inputFocusNode7.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(
            right: 8.0, left: 8.0, bottom: 10.0, top: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // _textField(context, _controller1, _inputFocusNode1,
            //     _inputFocusNode2, TextInputAction.next),
            // _textField(context, _controller2, _inputFocusNode2,
            //     _inputFocusNode3, TextInputAction.next),
            _textField(context, _controller3, _inputFocusNode3,
                _inputFocusNode4, TextInputAction.next),
            _textField(context, _controller4, _inputFocusNode4,
                _inputFocusNode5, TextInputAction.next),
            _textField(context, _controller5, _inputFocusNode5,
                _inputFocusNode6, TextInputAction.next),
            _textField(context, _controller6, _inputFocusNode6,
                _inputFocusNode7, TextInputAction.done),
          ],
        ),
      ),
    );
  }

  Widget _textField(
      BuildContext context,
      TextEditingController controller,
      FocusNode focusNode,
      FocusNode nextFocusNode,
      TextInputAction textInputAction) {
    return SizedBox(
      // width: 40,
      width: 60,
      height: 60,
      child: TextFormField(
          autofocus: true,
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
          maxLength: 1,
          cursorColor: Theme.of(context).scaffoldBackgroundColor,
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2)),
            focusColor: Theme.of(context).primaryColor,
          ),
          focusNode: focusNode,
          textInputAction: textInputAction,
          onChanged: (value) {
            setState(() {});
            if (controller.text.isNotEmpty)
              FocusScope.of(context).requestFocus(nextFocusNode);
          },
          onEditingComplete: () {
            if (controller.text.isNotEmpty)
              FocusScope.of(context).requestFocus(nextFocusNode);
          }),
    );
  }
}
