import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Location;
import 'package:new_turki/models/best_seller.dart';
import 'package:new_turki/models/category_data.dart';
import 'package:new_turki/repository/home_repository.dart';
import 'package:new_turki/repository/products_repository.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class HomeProvider with ChangeNotifier {
  bool _canPickup = true;
  bool _isLoading = true;
  bool _retry = false;
  bool _areaStatus = false;
  int _selectedOrderType = 0;
  //used to determine location service status
  int _locationServiceStatus = -1;
  CategoryData? _categoryData;
  BestSeller? _bestSeller;
  int _selectedAddress2 = 0;
  LatLng? _latLng;
  String? _isoCountryCode = 'SA';
  String? _currentIsoCountryCode = 'SA';
  Location.LocationData? _locationData;
  LatLng? get latLng => _latLng;
  BestSeller? get bestSeller => _bestSeller;
  bool get canPickup => _canPickup;
  bool get isLoading => _isLoading;
  bool get retry => _retry;
  bool get areaStatus => _areaStatus;
  int get selectedOrderType => _selectedOrderType;
  CategoryData get categoryData => _categoryData!;
  int get selectedAddress2 => _selectedAddress2;
  int get locationServiceStatus => _locationServiceStatus;
  String get isoCountryCode => _isoCountryCode!;

  String get currentIsoCountryCode => _currentIsoCountryCode!;

  set setIsLoading(bool value) {
    _isLoading = value;
    _retry = false;
    notifyListeners();
  }

  set setOrderType(int value) {
    _selectedOrderType = value;
    notifyListeners();
  }

  set setSelectedAddress2(int value) {
    _selectedAddress2 = value;
  }

  //init latLng
  Future<void> initLatLng() async {
    _locationData = await Location.Location().getLocation();
    //_latLng = LatLng(25.080002558191797, 55.13467766504166);
    _latLng = LatLng(_locationData!.latitude!, _locationData!.longitude!);
    _locationServiceStatus = 1;
    // init  isoCountryCode
    List<Placemark> placemark = await placemarkFromCoordinates(
        _latLng!.latitude, _latLng!.longitude,
        localeIdentifier: "EN");
    _currentIsoCountryCode = placemark.first.isoCountryCode;
    _isoCountryCode = placemark.first.isoCountryCode;
  }

  //get all categories
  Future<void> getCategories(LatLng latLng, String countryId) async {
    try {
      print("test:+" + latLng.toString() + countryId);
      _categoryData =
          await HomeRepository().getCategoriesList(latLng, countryId);
    } catch (e) {
      print(e.toString());
      _retry = true;
    }
  }

  //get Best Seller
  Future<void> getBestSeller(LatLng latLng, String countryId) async {
    try {
      _bestSeller = await ProductsRepository().getBestSeller(latLng, countryId);
    } catch (e) {
      print(e.toString());
      _retry = true;
    }
  }

  //init home page
  Future<void> getHomePageData(bool isCurrent,
      {LatLng latLng = const LatLng(0, 0),
      String countryId = "SA",
      bool isLoading = true}) async {
    _retry = false;
    _isLoading = isLoading;
    try {
      print("country :$countryId");
      if (isCurrent && _latLng == null) await initLatLng();
      if (isCurrent) {
        _latLng = LatLng(_locationData!.latitude!, _locationData!.longitude!);
        _isoCountryCode = _currentIsoCountryCode;
        // _latLng = LatLng(25.080002558191797, 55.13467766504166);
        // _isoCountryCode = 'AE';
        await Future.wait([
          getCategories(_latLng!, _isoCountryCode!),
          getBestSeller(_latLng!, _isoCountryCode!)
        ]);
      } else {
        print('else $countryId');
        await Future.wait([
          getCategories(latLng, countryId),
          getBestSeller(latLng, countryId)
        ]);
      }
    } catch (e) {
      _retry = true;
    }
    if (_latLng == null) {
      _locationServiceStatus = 0;
    }
    _isLoading = false;
    notifyListeners();
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      AppLocalizations.of(context)!.tr(msg),
      textAlign: TextAlign.center,
    )));
  }
}
