import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:huawei_location/huawei_location.dart';
import 'package:location/location.dart' as location_service;
import '../core/service/firebase_helper.dart';
import '../core/utilities/hms_latlng_converter.dart';
import '../core/utilities/get_strings.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';

class LocationProvider with ChangeNotifier {
  LatLng? _latLng;
  LatLng? _currentLocationLatLng;
  location_service.LocationData? _locationData;
  HWLocation? _hwlocation;

  //used to determine location service status
  int _locationServiceStatus = -1;
  String? _isoCountryCode;
  String? _currentLocationDescriptionAr = '';
  String? _currentLocationDescriptionEn = '';
  String? _currentLocationIsoCountryCode = 'SA';
  final location_service.Location _location = location_service.Location();
  bool isHms = false;

  String? get isoCountryCode => _isoCountryCode;
  LatLng? get latLng => _latLng; //init latLng
  String? get currentLocationDescriptionAr => _currentLocationDescriptionAr;
  String? get currentLocationDescriptionEn => _currentLocationDescriptionEn;
  int get locationServiceStatus => _locationServiceStatus;

  // int LatLng and location description
  Future<void> initLatLng({String languageCode = "ar"}) async {
    try {
      await fetchLocation();
      if (_locationServiceStatus != 0 && _locationServiceStatus != 2) {
        _currentLocationLatLng = isHms
            ? HMSLatLngConverter().convertToGMSLatLng(_hwlocation!)
            : LatLng(_locationData!.latitude!, _locationData!.longitude!);
        _latLng = _currentLocationLatLng;
        _locationServiceStatus = 1;

        /// init isoCountryCode
        List<Placemark> placemark = await placemarkFromCoordinates(
            _latLng!.latitude, _latLng!.longitude,
            localeIdentifier: 'ar');
        _currentLocationIsoCountryCode = placemark.first.isoCountryCode;
        _isoCountryCode = _currentLocationIsoCountryCode;
        Placemark place = placemark.first;
        _currentLocationDescriptionAr = GetStrings().locationDescription(place);
        List<Placemark> placemark2 = await placemarkFromCoordinates(
            _latLng!.latitude, _latLng!.longitude,
            localeIdentifier: "en");
        Placemark place2 = placemark2.first;
        FirebaseHelper()
            .pushAnalyticsEvent(name: "country", value: place2.country);
        FirebaseHelper()
            .pushAnalyticsEvent(name: "city", value: place2.locality);
        _currentLocationDescriptionEn =
            GetStrings().locationDescription(place2);
      }
      notifyListeners();
    } catch (e) {
      _locationServiceStatus = 2;
    }
  }

  // get current location
  Future<void> fetchLocation() async {
    if (_locationServiceStatus != -1) {
      _locationServiceStatus = -1;
      notifyListeners();
    }
    bool serviceEnabled;
    location_service.PermissionStatus permissionGranted;
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      _locationServiceStatus = 0;
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        _locationServiceStatus = 0;
        return;
      }
    }
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == location_service.PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != location_service.PermissionStatus.granted) {
        _locationServiceStatus = 0;
        return;
      }
    }
    if (Platform.isAndroid) {
      try {
        HmsApiAvailability hmsApiAvailability = HmsApiAvailability();
        final int resultCode = await hmsApiAvailability.isHMSAvailable();
        isHms = resultCode == 0 || resultCode == 2;
      } catch (_) {}
    }
    try {
      if (isHms) {
        FusedLocationProviderClient locationService =
            FusedLocationProviderClient();
        LocationRequest locationRequest = LocationRequest();
        _hwlocation =
            await locationService.getLastLocationWithAddress(locationRequest);
      } else {
        _locationData =
            await _location.getLocation().timeout(const Duration(seconds: 15));
      }
    } catch (_) {}
    //when app cannot get LatLng data and location service is enabled
    if (isHms) {
      if (_hwlocation == null) {
        _locationServiceStatus = 2;
      }
    } else if (_locationData == null) {
      _locationServiceStatus = 2;
    }
  }

  //update current Location Data
  void updateLocationData(String isoCountryCode, LatLng latLng) {
    _isoCountryCode = isoCountryCode;
    _latLng = latLng;
    notifyListeners();
  }

  //used when user select current location
  void selectCurrentLocation() {
    _latLng = _currentLocationLatLng;
    _isoCountryCode = _currentLocationIsoCountryCode;
    notifyListeners();
  }

  //used when user logout
  void initDataAfterLogout() {
    if (_locationServiceStatus == 1 || _currentLocationLatLng != null) {
      selectCurrentLocation();
    } else {
      _latLng = null;
      _currentLocationLatLng = null;
      _isoCountryCode = 'SA';
      _currentLocationIsoCountryCode = null;
      notifyListeners();
    }
  }
}
