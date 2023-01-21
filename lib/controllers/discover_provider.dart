import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/service/service_locator.dart';
import '../core/utilities/enum/request_status.dart';
import '../models/discover_item.dart';
import '../repository/home_repository.dart';

class DiscoverProvider with ChangeNotifier {
  RequestStatus _requestStatus = RequestStatus.isLoading;
  DiscoverItem? _discoverItem;
  LatLng? _latLng;
  String? _isoCountryCode;

  RequestStatus get requestStatus => _requestStatus;
  DiscoverItem? get discoverItem => _discoverItem;

  Future<void> getDiscoverItem(int id) async {
    _requestStatus = RequestStatus.isLoading;
    try {
      _discoverItem = await sl<HomeRepository>()
          .getDiscoverItem(id, _latLng!, _isoCountryCode!);
      _requestStatus = RequestStatus.completed;
    } catch (_) {
      _requestStatus = RequestStatus.error;
    }
    notifyListeners();
  }

  // update location data
  Future<void> updateLocation(
    LatLng? latLng,
    String? isoCountryCode,
  ) async {
    if (latLng != null) {
      if (latLng != _latLng) {
        _latLng = latLng;
        _isoCountryCode = isoCountryCode;
      }
    }
  }
}
