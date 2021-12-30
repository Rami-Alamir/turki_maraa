import 'package:flutter/material.dart';
import 'package:new_turki/models/favourite.dart';
import 'package:new_turki/repository/favourite_repository.dart';
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

  // remove favourite item
  Future<void> removeFavouriteItem(
      BuildContext context, int index, String authorization) async {
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
