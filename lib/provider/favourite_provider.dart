import 'package:flutter/material.dart';
import 'package:new_turki/models/favourite.dart';
import 'package:new_turki/repository/favourite_repository.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';
import 'package:provider/provider.dart';

import 'home_provider.dart';

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
  Future<void> getFavouriteData(String authorization,
      {bool isLoading = true}) async {
    _isLoading = isLoading;
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

  // delete item from favourite list
  Future<void> deleteFromFavourite({
    required BuildContext context,
    required String authorization,
    required String id,
    bool isLoading = true,
    int index = -1,
  }) async {
    var _response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _response =
          await FavouriteRepository().deleteFromFavourite(id, authorization);
      if (_response == 200) {
        final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
        _homeProvider.setIsFavourite2 = false;
        if (index > -1) _favourite!.dataT!.data!.removeAt(index);
        getFavouriteData(authorization, isLoading: isLoading);
      }
    } catch (e) {
      print('catch');
      print(e.toString());
      showSnackBar(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
    notifyListeners();
  }

  // add item to favourite list
  Future<void> addToFavourite(
      {required BuildContext context,
      required String authorization,
      required String id,
      bool withDialog = true}) async {
    var _response;

    _dialogContext = context;
    if (withDialog) _showDialogIndicator(context);
    try {
      _response = await FavouriteRepository().addFavourite(id, authorization);
      if (_response == 200) {
        final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
        _homeProvider.setIsFavourite2 = true;

        getFavouriteData(authorization);
      } else
        showSnackBar(context, "unexpected_error");
    } catch (e) {
      print('catch');
      print(e.toString());
      showSnackBar(context, "unexpected_error");
    }
    if (withDialog) {
      Navigator.pop(_dialogContext!);
      notifyListeners();
    }
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

  bool isFavourite(int id) {
    print("isFavourite");
    print("id:$id");
    print("total:${(_favourite?.dataT?.data?.length ?? 0)}");

    if ((_favourite?.dataT?.data?.length ?? 0) > 0)
      for (int i = 0; i < _favourite!.dataT!.data!.length; i++) {
        if (id == _favourite!.dataT!.data![i].product!.id) return true;
      }
    return false;
  }

  int getFavouriteId(int id) {
    if ((_favourite?.dataT?.data?.length ?? 0) > 0)
      for (int i = 0; i < _favourite!.dataT!.data!.length; i++) {
        if (id == _favourite!.dataT!.data![i].product!.id)
          return _favourite!.dataT!.data![i].id!;
      }
    return 0;
  }
}
