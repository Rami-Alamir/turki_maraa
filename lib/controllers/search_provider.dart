import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/service/service_locator.dart';
import '../models/search_data.dart';
import '../repository/search_repository.dart';

class SearchProvider with ChangeNotifier {
  List<SearchData> _searchData = [];
  LatLng? _latLng;
  String? _isoCountryCode;

  List<SearchData> get searchData => _searchData;

  // update location data
  Future<void> updateLocation(
    LatLng? latLng,
    String? isoCountryCode,
  ) async {
    if (latLng != null) {
      if (latLng != _latLng) {
        _searchData = [];
        _latLng = latLng;
        _isoCountryCode = isoCountryCode;
      }
    }
  }

  Future<void> getSearchResultList(String key) async {
    try {
      _searchData = await sl<SearchRepository>()
          .getSearchResultList(key, _latLng!, _isoCountryCode!);
    } catch (_) {
      _searchData = [];
    }
    notifyListeners();
  }
}
