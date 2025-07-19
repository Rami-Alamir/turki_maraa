import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
// import 'package:huawei_location/huawei_location.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:async';
// import 'dart:io';
import 'package:location/location.dart' as location_service;
import '../core/constants/constants.dart';
import '../core/service/firebase_helper.dart';
import '../core/service/service_locator.dart';
import '../core/utilities/calculate_helper.dart';
import '../core/utilities/enum/location_service_status.dart';
import '../core/utilities/get_strings.dart';
// import '../core/utilities/hms_latlng_converter.dart';
import '../models/location_data.dart';

class LocationProvider with ChangeNotifier {
  bool _customerHaveLocation = false;
  bool _customerLocationIsDifferent = false;
  int? _customerLocationId;
  LatLng? _latLng;
  LatLng? _currentLocationLatLng;
  location_service.LocationData? _locationData;
  // HWLocation? _hwlocation;
  String? _selectedLocationDescription;
  LocationServiceStatus _locationServiceStatus =
      LocationServiceStatus.beingDetermined;
  String? _isoCountryCode;
  String? _currentLocationDescription = '';
  String? _currentLocationIsoCountryCode = 'SA';
  final location_service.Location _location = location_service.Location();
  bool isHms = false;

  bool get customerHaveLocation => _customerHaveLocation;
  String? get isoCountryCode => _isoCountryCode;
  LatLng? get latLng => _latLng;
  String? get currentLocationDescription => _currentLocationDescription;
  LocationServiceStatus get locationServiceStatus => _locationServiceStatus;
  String get selectedLocationDescription => _selectedLocationDescription ?? "";
  LatLng? get currentLocationLatLng => _currentLocationLatLng;
  int? get customerLocationId => _customerLocationId;
  bool get customerLocationIsDifferent => _customerLocationIsDifferent;

  set customerLocationIsDifferent(bool value) {
    _customerLocationIsDifferent = value;
    notifyListeners();
  }

  Future<void> initLatLng(String languageCode) async {
    await _getLocation();
    try {
      await fetchLocation();
      if (_locationServiceStatus != LocationServiceStatus.noAccess &&
          _locationServiceStatus != LocationServiceStatus.unableToDetermine) {
        _currentLocationLatLng =
            // isHms
            //     ? sl<HMSLatLngConverter>().convertToGMSLatLng(_hwlocation!)
            //     :
            LatLng(_locationData!.latitude!, _locationData!.longitude!);
        _latLng ??= _currentLocationLatLng;
        _locationServiceStatus = LocationServiceStatus.fetched;
        notifyListeners();
        if (_customerHaveLocation) {
          _customerLocationIsDifferent =
              sl<CalculateHelper>().calculateDistance(
                _latLng,
                _currentLocationLatLng,
              ) >
              0.1;
        }
        await currentLocationPlacemarkDescription();
        if (_locationData != null) {
          _saveLocation(
            latitude: _locationData!.latitude!,
            longitude: _locationData!.longitude!,
            selectedLocationDescription: (currentLocationDescription ?? ""),
            isoCountryCode: _currentLocationIsoCountryCode ?? "",
          );
        }
      }
    } catch (_) {
      _locationServiceStatus = LocationServiceStatus.unableToDetermine;
    }
    notifyListeners();
  }

  Future<void> currentLocationPlacemarkDescription() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
      _currentLocationLatLng!.latitude,
      _currentLocationLatLng!.longitude,
    );
    _currentLocationIsoCountryCode = placemark.first.isoCountryCode;
    _isoCountryCode ??= _currentLocationIsoCountryCode;
    Placemark place = placemark.first;
    _currentLocationDescription = sl<GetStrings>().locationDescription(place);
  }

  Future<void> fetchLocation() async {
    if (_locationServiceStatus != LocationServiceStatus.beingDetermined) {
      _locationServiceStatus = LocationServiceStatus.beingDetermined;
      notifyListeners();
    }
    bool serviceEnabled;
    location_service.PermissionStatus permissionGranted;
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      _locationServiceStatus = LocationServiceStatus.noAccess;
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        _locationServiceStatus = LocationServiceStatus.noAccess;
        return;
      }
    }
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == location_service.PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != location_service.PermissionStatus.granted) {
        _locationServiceStatus = LocationServiceStatus.noAccess;
        return;
      }
    }
    // if (Platform.isAndroid) {
    //   try {
    //     HmsApiAvailability hmsApiAvailability = HmsApiAvailability();
    //     final int resultCode = await hmsApiAvailability.isHMSAvailable();
    //     isHms = resultCode == 0 || resultCode == 2;
    //   } catch (_) {}
    // }
    try {
      // if (isHms) {
      //   FusedLocationProviderClient locationService =
      //       FusedLocationProviderClient();
      //   locationService.initFusedLocationService();
      //   LocationRequest locationRequest = LocationRequest();
      //   _hwlocation =
      //       await locationService.getLastLocationWithAddress(locationRequest);
      // } else {
      //   _locationData =
      //       await _location.getLocation().timeout(const Duration(seconds: 15));
      // }
      _locationData = await _location.getLocation().timeout(
        const Duration(seconds: 15),
      );
    } catch (_) {
      _locationServiceStatus = LocationServiceStatus.unableToDetermine;
    }
    //when app cannot get LatLng data and location service is enabled
    // if (isHms) {
    //   if (_hwlocation == null) {
    //     _locationServiceStatus = LocationServiceStatus.unableToDetermine;
    //   }
    // } else
    if (_locationData == null) {
      _locationServiceStatus = LocationServiceStatus.unableToDetermine;
    }
  }

  //update current Location Data
  void updateLocationData(
    String countryCode,
    LatLng latLng, {
    bool setSelected = false,
    String address = '',
    int? id,
  }) {
    // print('updateLocationData');
    // print('address $address');
    _customerLocationId = null;
    _customerHaveLocation = false;
    _isoCountryCode = countryCode;
    _latLng = latLng;
    if (setSelected) {
      _setSelectedLocationDescription();
    } else {
      _selectedLocationDescription = address;
    }
    // print('_selectedLocationDescription $_selectedLocationDescription');
    _saveLocation(
      id: id,
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      selectedLocationDescription: address,
      isoCountryCode: countryCode,
    );
    notifyListeners();
  }

  //used when user select current location
  void selectCurrentLocation(String language) {
    _customerLocationId = null;
    _customerHaveLocation = false;
    _latLng = _currentLocationLatLng;
    _isoCountryCode = _currentLocationIsoCountryCode;
    _selectedLocationDescription = _currentLocationDescription!;
    _saveLocation(
      latitude: _currentLocationLatLng!.latitude,
      longitude: _currentLocationLatLng!.longitude,
      selectedLocationDescription: _selectedLocationDescription ?? "",
      isoCountryCode: _currentLocationIsoCountryCode ?? "",
    );
    notifyListeners();
  }

  Future<void> _setSelectedLocationDescription() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
      _latLng!.latitude,
      _latLng!.longitude,
    );
    Placemark place = placemark.first;
    _selectedLocationDescription = sl<GetStrings>().locationDescription(place);
    notifyListeners();
  }

  //used when user logout
  void initDataAfterLogout() {
    if (_locationServiceStatus == LocationServiceStatus.fetched ||
        _currentLocationLatLng != null) {
      selectCurrentLocation('ar');
    } else {
      _latLng = null;
      _customerHaveLocation = false;
      _customerLocationId = null;
      _currentLocationLatLng = null;
      _isoCountryCode = 'SA';
      _currentLocationIsoCountryCode = null;
      notifyListeners();
    }
  }

  Future<void> _saveLocation({
    int? id,
    required double latitude,
    required double longitude,
    required String selectedLocationDescription,
    required String isoCountryCode,
  }) async {
    try {
      final LocalStorage storage = LocalStorage(Constants.localStorage);
      await storage.setItem(
        Constants.locationData,
        LocationData(
          id: id,
          latitude: latitude,
          longitude: longitude,
          isoCountryCode: isoCountryCode,
          selectedLocationDescription: selectedLocationDescription,
        ).toJson(),
      );
    } catch (_) {}
  }

  Future<void> _getLocation() async {
    try {
      final LocalStorage storage = LocalStorage(Constants.localStorage);
      await storage.ready;
      LocationData? locationData = LocationData.fromJson(
        storage.getItem(Constants.locationData),
      );
      _latLng = LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0);
      _isoCountryCode = locationData.isoCountryCode ?? "";
      _selectedLocationDescription =
          locationData.selectedLocationDescription ?? "";
      _locationServiceStatus = LocationServiceStatus.savedLocation;
      _customerHaveLocation = true;
      _customerLocationId = locationData.id;
      FirebaseHelper().subscribeToTopic(_isoCountryCode!);
      notifyListeners();
    } catch (_) {}
  }
}
