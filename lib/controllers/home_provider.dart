import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location_service;
import '../models/banners_data.dart';
import '../models/best_seller.dart';
import '../models/category_data.dart';
import '../repository/home_repository.dart';
import '../repository/products_repository.dart';
import '../repository/version_repository.dart';
import '../presentation/screens/other/new_version.dart' as new_version;
import 'package:version/version.dart';

class HomeProvider with ChangeNotifier {
  bool _canUpdate = false;
  final bool _canPickup = true;
  bool _isLoading = true;
  bool _retry = false;
  final bool _areaStatus = false;
  int _selectedOrderType = 0;
  //used to determine location service status
  int _locationServiceStatus = 2;
  CategoryData? _categoryData;
  BestSeller? _bestSeller;
  LatLng? _latLng;
  String? _isoCountryCode;
  bool? _isHMS = false;
  location_service.LocationData? _locationData;
  final String _currentVersion = "5.13.1";
  location_service.Location location = location_service.Location();
  BannersData? _bannersData;

  // update location data
  Future<void> updateLocation(
      LatLng? latLng,
      String? isoCountryCode,
      int? locationServiceStatus,
      String? currentLocationDescriptionAr,
      String? currentLocationDescriptionEn,
      bool isHMS) async {
    _locationServiceStatus = locationServiceStatus ?? 2;
    _isHMS = isHMS;
    if (_isHMS ?? false) {
      checkNewVersion();
    }
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
        _isLoading = true;
      }
      _latLng = latLng;
      _isoCountryCode = isoCountryCode;
      notifyListeners();
    }
  }

  location_service.LocationData get locationData => _locationData!;
  LatLng? get latLng => _latLng;
  int get selectedOrderType => _selectedOrderType;
  String get currentVersion => _currentVersion;
  BestSeller? get bestSeller => _bestSeller;
  bool get canPickup => _canPickup;
  bool get isLoading => _isLoading;
  bool get retry => _retry;
  bool get areaStatus => _areaStatus;
  CategoryData? get categoryData => _categoryData;
  int get locationServiceStatus => _locationServiceStatus;
  String get isoCountryCode => _isoCountryCode!;
  bool get canUpdate => _canUpdate;
  BannersData? get bannersData => _bannersData;

  set setIsLoading(bool value) {
    _isLoading = value;
    _retry = false;
    notifyListeners();
  }

  set setOrderType(int value) {
    _selectedOrderType = value;
    notifyListeners();
  }

  //get all categories
  Future<void> _getCategories() async {
    try {
      _categoryData =
          await HomeRepository().getCategoriesList(_latLng!, _isoCountryCode!);
    } catch (e) {
      _retry = true;
    }
  }

  //get Best Seller
  Future<void> _getBestSeller() async {
    try {
      _bestSeller =
          await ProductsRepository().getBestSeller(_latLng!, _isoCountryCode!);
    } catch (e) {
      _retry = true;
    }
  }

  //init home page
  Future<void> getHomePageData(
      {bool isLoading = true, bool notify = true}) async {
    _retry = false;
    try {
      if (_latLng != null && _isoCountryCode != null) {
        _isLoading = isLoading;
        notifyListeners();
        await Future.wait([
          _getCategories(),
          _getBestSeller(),
        ]);
      }
    } catch (e) {
      _retry = true;
    }
    _isLoading = false;
    if (notify) {
      notifyListeners();
    }
  }

  // check if app have new version to show update page
  Future<void> checkNewVersion() async {
    final versionData =
        await VersionRepository().getLatestAppVersion(Platform.isIOS
            ? 1
            : _isHMS!
                ? 3
                : 2);

    Version currentVersion = Version.parse(_currentVersion);
    Version latestVersion =
        Version.parse(versionData.data?.value ?? _currentVersion);
    if (latestVersion > currentVersion) _canUpdate = true;
  }

  // show new version page
  void showNewVersion(BuildContext context) async {
    if (_canUpdate) {
      _canUpdate = false;
      await Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.of(
          context,
          rootNavigator: true,
        ).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    const new_version.NewVersion()),
            ModalRoute.withName('/'));
      });
    }
  }
}
