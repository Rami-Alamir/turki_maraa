import 'package:flutter/material.dart';
import 'package:new_turki/models/favourite.dart';
import 'package:new_turki/repository/favourite_repository.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';

class FavouriteProvider with ChangeNotifier {
  TextEditingController noteController = TextEditingController();
  bool _isLoading = true;
  bool _retry = false;
  Favourite? _favourite;

  Favourite get favourite => _favourite!;

  bool get isLoading => _isLoading;
  bool get retry => _retry;
  BuildContext? _dialogContext;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // get favourite list
  Future<void> getFavouriteData(String authorization) async {
    _isLoading = true;
    _retry = false;
    try {
      _favourite = await FavouriteRepository().getFavouriteList(authorization);
    } catch (e) {
      _retry = true;
      print(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteFromFavourite({
    required BuildContext context,
    required String authorization,
    required String id,
    required int index,
  }) async {
    var _response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _response =
          await FavouriteRepository().deleteFromFavourite(id, authorization);
      if (_response == 200) _favourite!.dataT!.data!.removeAt(index);
    } catch (e) {
      print('catch');
      print(e.toString());
      showSnackBar(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
    notifyListeners();
  }

  Future<void> addToFavourite({
    required BuildContext context,
    required String authorization,
    required String id,
  }) async {
    var _response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _response = await FavouriteRepository().addFavourite(id, authorization);
      if (_response == 200)
        showSnackBar(
            context, "The_product_has_not_been_added_to_the_favourites");
    } catch (e) {
      print('catch');
      print(e.toString());
      showSnackBar(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
    notifyListeners();
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      AppLocalizations.of(context)!.tr(msg),
      textAlign: TextAlign.center,
    )));
  }

  // show indicator dialog
  void _showDialogIndicator(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dialogContext = context;
          return IndicatorDialog();
        });
  }
}
