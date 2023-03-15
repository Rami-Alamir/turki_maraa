import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location_service;
import '../core/service/service_locator.dart';
import '../core/utilities/enum/request_status.dart';
import '../models/banners_data.dart';
import '../models/best_seller.dart';
import '../models/category_data.dart';
import '../repository/home_repository.dart';
import '../repository/products_repository.dart';

class HomeProvider with ChangeNotifier {
  RequestStatus _requestStatus = RequestStatus.isLoading;
  final bool _canPickup = true;
  final bool _areaStatus = false;
  int _selectedOrderType = 0;
  //used to determine location service status
  int _locationServiceStatus = 2;
  CategoryData? _categoryData;
  BestSeller? _bestSeller;
  LatLng? _latLng;
  String? _isoCountryCode;
  location_service.LocationData? _locationData;
  location_service.Location location = location_service.Location();
  BannersData? _bannersData;

  location_service.LocationData get locationData => _locationData!;
  LatLng? get latLng => _latLng;
  int get selectedOrderType => _selectedOrderType;
  BestSeller? get bestSeller => _bestSeller;
  bool get canPickup => _canPickup;
  bool get areaStatus => _areaStatus;
  CategoryData? get categoryData => _categoryData;
  int get locationServiceStatus => _locationServiceStatus;
  String get isoCountryCode => _isoCountryCode!;
  BannersData? get bannersData => _bannersData;
  RequestStatus get requestStatus => _requestStatus;

  // update location data
  Future<void> updateLocation(
      LatLng? latLng,
      String? isoCountryCode,
      int? locationServiceStatus,
      String? currentLocationDescriptionAr,
      String? currentLocationDescriptionEn,
      bool isHMS) async {
    _locationServiceStatus = locationServiceStatus ?? 2;

    if (latLng != null) {
      _isoCountryCode = isoCountryCode;
      if (latLng != _latLng) {
        _latLng = latLng;
        getHomePageData();
      } else if (_categoryData == null) {
        getHomePageData();
      }
    } else {
      if (_locationServiceStatus != 0 || _locationServiceStatus != 2) {
        _requestStatus = RequestStatus.isLoading;
      }
      _latLng = latLng;
      _isoCountryCode = isoCountryCode;
      notifyListeners();
    }
  }

  set setIsLoading(bool value) {
    _requestStatus = RequestStatus.isLoading;
    notifyListeners();
  }

  set setOrderType(int value) {
    _selectedOrderType = value;
    notifyListeners();
  }

  //get all categories
  Future<void> _getCategories() async {
    try {
      _categoryData = await sl<HomeRepository>()
          .getCategoriesList(_latLng!, _isoCountryCode!);
    } catch (_) {
      _requestStatus = RequestStatus.error;
    }
  }

  //get Best Seller
  Future<void> _getBestSeller() async {
    try {
      _bestSeller = await sl<ProductsRepository>()
          .getBestSeller(_latLng!, _isoCountryCode!);
    } catch (_) {
      _requestStatus = RequestStatus.error;
    }
  }

  //init home page
  Future<void> getHomePageData({bool notify = true}) async {
    _requestStatus = RequestStatus.isLoading;
    try {
      if (_latLng != null && _isoCountryCode != null) {
        if (notify) {
          notifyListeners();
        }
        await Future.wait([
          _getCategories(),
          _getBestSeller(),
        ]);
      }
      _requestStatus = RequestStatus.completed;
    } catch (_) {
      _requestStatus = RequestStatus.error;
    }
    notifyListeners();
  }
}
