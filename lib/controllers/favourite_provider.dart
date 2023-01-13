import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'products_provider.dart';
import '../models/favourite.dart';
import '../repository/favourite_repository.dart';
import '../core/utilities/show_snack_bar.dart';
import '../core/service/service_locator.dart';
import '../presentation/widgets/dialog/indicator_dialog.dart';

class FavouriteProvider with ChangeNotifier {
  TextEditingController noteController = TextEditingController();
  bool _isLoading = true;
  bool _retry = false;
  bool _isAuth = false;
  Favourite? _favourite;
  String? _accessToken;
  LatLng? _latLng;
  String? _isoCountryCode;
  BuildContext? _dialogContext;

  String get isoCountryCode => _isoCountryCode!;
  Favourite? get favourite => _favourite;
  bool get isAuth => _isAuth;
  bool get isLoading => _isLoading;
  bool get retry => _retry;
  LatLng? get latLng => _latLng;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void updateFavouriteProvider(
      String accessToken, bool isAuth, LatLng? latLng, String? isoCountryCode) {
    _accessToken = accessToken;
    _isAuth = isAuth;
    if (isAuth && _favourite == null && accessToken.isNotEmpty) {
      getFavouriteData();
    } else if (!_isAuth) {
      _favourite = null;
    }
    if (latLng != null) {
      if (latLng != _latLng) {
        _latLng = latLng;
        _isoCountryCode = isoCountryCode;
        getFavouriteData();
      }
    } else {
      _favourite = null;
      _latLng = latLng;
      _isoCountryCode = isoCountryCode;
      notifyListeners();
    }
  }

  // get favourite list
  Future<void> getFavouriteData({bool isLoading = true}) async {
    if (isAuth) {
      _isLoading = isLoading;
      _retry = false;
      try {
        _favourite = await sl<FavouriteRepository>().getFavouriteList(
            "Bearer ${_accessToken!}", _latLng!, _isoCountryCode!);
      } catch (e) {
        _retry = true;
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  // delete item from favourite list
  Future<void> deleteFromFavourite({
    required BuildContext context,
    required String id,
    bool isLoading = true,
    int index = -1,
  }) async {
    int response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      response = await sl<FavouriteRepository>()
          .deleteFromFavourite(id, "Bearer ${_accessToken!}");
      if (response == 200) {
        final productsProvider =
            // ignore: use_build_context_synchronously
            Provider.of<ProductsProvider>(context, listen: false);
        productsProvider.setIsFavourite2 = false;
        if (index > -1) _favourite!.dataT!.data!.removeAt(index);
        getFavouriteData(isLoading: isLoading);
      }
    } catch (e) {
      ShowSnackBar().show(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
    notifyListeners();
  }

  // add item to favourite list
  Future<void> addToFavourite(
      {required BuildContext context,
      required String id,
      bool withDialog = true}) async {
    int response;
    _dialogContext = context;
    if (withDialog) _showDialogIndicator(context);
    try {
      response = await sl<FavouriteRepository>()
          .addFavourite(id, "Bearer ${_accessToken!}");
      if (response == 200) {
        final productsProvider =
            // ignore: use_build_context_synchronously
            Provider.of<ProductsProvider>(context, listen: false);
        productsProvider.setIsFavourite2 = true;
        getFavouriteData();
      } else {
        // ignore: use_build_context_synchronously
        ShowSnackBar().show(context, "unexpected_error");
      }
    } catch (e) {
      ShowSnackBar().show(context, "unexpected_error");
    }
    if (withDialog) {
      Navigator.pop(_dialogContext!);
      notifyListeners();
    }
  }

  // show indicator dialog
  void _showDialogIndicator(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dialogContext = context;
          return const IndicatorDialog();
        });
  }

  // return product favourite status
  bool isFavourite(int id) {
    if ((_favourite?.dataT?.data?.length ?? 0) > 0) {
      for (int i = 0; i < _favourite!.dataT!.data!.length; i++) {
        if (id == _favourite!.dataT!.data![i].product!.id) {
          return true;
        }
      }
    }
    return false;
  }

  int getFavouriteId(int id) {
    if ((_favourite?.dataT?.data?.length ?? 0) > 0) {
      for (int i = 0; i < _favourite!.dataT!.data!.length; i++) {
        if (id == _favourite!.dataT!.data![i].product!.id) {
          return _favourite!.dataT!.data![i].id!;
        }
      }
    }
    return 0;
  }
}
