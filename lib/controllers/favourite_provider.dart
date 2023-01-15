import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/service/firebase_helper.dart';
import '../core/service/service_locator.dart';
import '../core/utilities/dialog_helper.dart';
import '../core/utilities/enum/request_status.dart';
import '../models/favourite.dart';
import '../repository/favourite_repository.dart';

class FavouriteProvider with ChangeNotifier {
  TextEditingController noteController = TextEditingController();
  RequestStatus _requestStatus = RequestStatus.isLoading;
  bool _isAuth = false;
  Favourite? _favourite;
  String? _accessToken;
  LatLng? _latLng;
  String? _isoCountryCode;

  String get isoCountryCode => _isoCountryCode!;
  Favourite? get favourite => _favourite;
  bool get isAuth => _isAuth;
  RequestStatus get requestStatus => _requestStatus;
  LatLng? get latLng => _latLng;

  void updateFavouriteProvider(
      String accessToken, bool isAuth, LatLng? latLng, String? isoCountryCode) {
    _accessToken = accessToken;
    _isAuth = isAuth;
    if (isAuth && _favourite == null && accessToken.isNotEmpty) {
      getFavouriteList();
    } else if (!_isAuth) {
      _favourite = null;
    }
    if (latLng != null) {
      if (latLng != _latLng) {
        _latLng = latLng;
        _isoCountryCode = isoCountryCode;
        getFavouriteList();
      }
    } else {
      _favourite = null;
      _latLng = latLng;
      _isoCountryCode = isoCountryCode;
      notifyListeners();
    }
  }

  Future<void> getFavouriteList({bool notify = false}) async {
    if (isAuth) {
      _requestStatus = RequestStatus.isLoading;
      if (notify) {
        notifyListeners();
      }
      try {
        _favourite = await sl<FavouriteRepository>().getFavouriteList(
            "Bearer ${_accessToken!}", _latLng!, _isoCountryCode!);
        _requestStatus = RequestStatus.completed;
      } catch (_) {
        _requestStatus = RequestStatus.error;
      }
      notifyListeners();
    }
  }

  Future<bool> deleteFromFavourite({
    required BuildContext context,
    required String id,
    required String productName,
    bool notify = true,
    int index = -1,
  }) async {
    int response;
    sl<DialogHelper>().showIndicatorDialog(context);
    try {
      response = await sl<FavouriteRepository>()
          .deleteFromFavourite(id, "Bearer ${_accessToken!}");
      FirebaseHelper().pushAnalyticsEvent(
          name: 'delete_from_favourite', value: productName);
      if (response == 200) {
        if (index > -1) _favourite!.dataT!.data!.removeAt(index);
        getFavouriteList(notify: notify);
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> addToFavourite(
      {required BuildContext context,
      required String id,
      required String productName,
      bool withDialog = true}) async {
    int response;
    if (withDialog) {
      sl<DialogHelper>().showIndicatorDialog(context);
    }
    try {
      response = await sl<FavouriteRepository>()
          .addFavourite(id, "Bearer ${_accessToken!}");
      FirebaseHelper()
          .pushAnalyticsEvent(name: 'add_to_favourite', value: productName);
      if (response == 200) {
        getFavouriteList(notify: withDialog);
        return true;
      }
    } catch (_) {}
    return false;
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
