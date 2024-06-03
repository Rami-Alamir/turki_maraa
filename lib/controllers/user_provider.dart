import 'dart:convert';
import 'package:flutter/material.dart';
import '../core/utilities/dialog_helper.dart';
import '../models/user_data.dart';
import '../repository/user_repository.dart';
import '../core/service/service_locator.dart';

class UserProvider with ChangeNotifier {
  TextEditingController ageController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  // TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  UserData? _userData;
  String? _accessToken;
  //used to update gender
  // int? _gender = -1;

  UserData? get userData => _userData;
  // int get gender => _gender!;

  //used when auth provider changed
  void updateUserData(UserData? userData) {
    _userData = userData;
    _accessToken = _userData?.data?.accessToken ?? "";
    initTextController();
    notifyListeners();
  }

  Future<int> updateUser(BuildContext context) async {
    if (usernameController.text.trim().isNotEmpty ||
        ageController.text.trim().isNotEmpty ||
        emailController.text.trim().isNotEmpty) {
      sl<DialogHelper>().showIndicatorDialog(context);
      try {
        var response = await sl<UserRepository>().updateInfo({
          if (usernameController.text.trim().isNotEmpty)
            "name": usernameController.text,
          if (ageController.text.trim().isNotEmpty)
            "age": ageController.text.trim(),
          if (emailController.text.trim().isNotEmpty &&
              _userData!.data!.email! != emailController.text.trim())
            "email": emailController.text.trim(),
          // if (_gender! > -1) "gender": "$_gender",
        }, "Bearer $_accessToken");
        if (response.statusCode == 200) {
          _userData = UserData.fromJson(json.decode(response.body.toString()));
          if (context.mounted) initTextController(context: context);
          notifyListeners();
        }
        return response.statusCode;
      } catch (_) {}
      return 0;
    }
    return 1;
  }

  // void setGender(int value, BuildContext context) {
  //   _gender = value;
  //   genderController.text = sl<GetStrings>().getGender(context, value);
  //   notifyListeners();
  // }

  void initTextController({BuildContext? context}) {
    ageController.text = (_userData?.data?.age ?? "");
    usernameController.text = _userData?.data?.name ?? "";
    emailController.text = _userData?.data?.email ?? "";
    // initGenderController(context: context);
  }

  // void initGenderController({BuildContext? context}) {
  //   try {
  //     if (context != null) {
  //       genderController.text = sl<GetStrings>()
  //           .getGender(context, int.parse((_userData?.data?.gender ?? "-1")));
  //     }
  //   } catch (_) {
  //     genderController.text = "";
  //   }
  // }
}
