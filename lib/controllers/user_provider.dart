import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/user_data.dart';
import '../repository/user_repository.dart';
import '../core/utilities/get_strings.dart';
import '../core/utilities/show_snack_bar.dart';
import '../presentation/widgets/dialog/indicator_dialog.dart';

class UserProvider with ChangeNotifier {
  TextEditingController ageController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  UserData? _userData;
  String? _accessToken;

  //used to update gender
  int? _gender = -1;
  //used to hide dialog indicator
  BuildContext? _dialogContext;

  UserData? get userData => _userData;
  int get gender => _gender!;

  //used when auth provider changed
  void updateUserData(UserData? userData) {
    _userData = userData;
    _accessToken = _userData?.data?.accessToken ?? "";
    initTextController();
  }

  // update user data
  Future<void> updateUser(BuildContext context, {bool showMsg = true}) async {
    _dialogContext = context;
    if (usernameController.text.isNotEmpty ||
        ageController.text.isNotEmpty ||
        emailController.text.isNotEmpty) {
      _showDialogIndicator(_dialogContext);
      try {
        var response = await UserRepository().updateInfo({
          if (usernameController.text.trim().isNotEmpty)
            "name": usernameController.text,
          if (ageController.text.trim().isNotEmpty)
            "age": ageController.text.trim(),
          if (emailController.text.trim().isNotEmpty &&
              _userData!.data!.email! != emailController.text.trim())
            "email": emailController.text.trim(),
          if (_gender! > -1) "gender": "$_gender",
        }, "Bearer $_accessToken");
        if (response.statusCode == 200) {
          _userData = UserData.fromJson(json.decode(response.body.toString()));
          initTextController(context: context);
          if (showMsg) {
            // ignore: use_build_context_synchronously
            ShowSnackBar().show(context, 'data_has_been_updated_successfully');
          }
          Navigator.pop(_dialogContext!);
        } else {
          Navigator.pop(_dialogContext!);

          // ignore: use_build_context_synchronously
          ShowSnackBar().show(
              context,
              response.statusCode == 400 && showMsg
                  ? "email_is_used_please_enter_different_email"
                  : "unexpected_error");
        }
      } catch (e) {
        if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
        ShowSnackBar().show(context, "unexpected_error");
      }
      notifyListeners();
    }
  } // update user data

  void setGender(int value, BuildContext context) {
    _gender = value;
    genderController.text = GetStrings().getGender(context, value);
    notifyListeners();
  }

  void initTextController({BuildContext? context}) {
    ageController.text = (_userData?.data?.age ?? "");
    usernameController.text = _userData?.data?.name ?? "";
    try {
      if (context != null) {
        genderController.text = GetStrings()
            .getGender(context, int.parse((_userData?.data?.gender ?? "-1")));
      } else {
        genderController.text = '';
        _gender = -1;
      }
    } catch (e) {
      genderController.text = "";
    }
    emailController.text = _userData?.data?.email ?? "";
  }

  void _showDialogIndicator(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dialogContext = context;
          return const IndicatorDialog();
        });
  }
}
