import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/models/user_address.dart';
import 'package:new_turki/repository/user_repository.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';
import 'package:provider/provider.dart';
import '../utilities/get_strings.dart';
import 'home_provider.dart';
import 'package:huawei_map/map.dart' as HMS;

class AddressProvider with ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  BitmapDescriptor? _myMarker;
  String? _addressDescription;
  LatLng? _selectedLatLng;
  LatLng? _mapLatLng;
  bool? _initMap = false;
  HMS.BitmapDescriptor? _hmsMarker;
  UserAddress? _userAddress;
  BuildContext? _dialogContext;
  int _selectedAddress = -1;
  String? _isoCountryCode = 'SA';
  int get selectedAddress => _selectedAddress;
  bool get initMap => _initMap!;
  HMS.BitmapDescriptor? get hmsMarker => _hmsMarker;
  UserAddress? get userAddress => _userAddress;
  LatLng get selectedLatLng =>
      _selectedLatLng ?? LatLng(24.727726176454684, 46.58666208381939);
  BitmapDescriptor? get myMarker => _myMarker;
  String? get addressDescription => _addressDescription;
  String get isoCountryCode => _isoCountryCode!;
  LatLng get mapLatLng =>
      _mapLatLng ?? LatLng(24.727726176454684, 46.58666208381939);

  set initMap(bool value) {
    _initMap = value;
  }

  void clearDescription() {
    _selectedLatLng = null;
    _addressDescription = null;
  }

  set setUserAddress(UserAddress value) {
    _userAddress = value;
  }

  set setSelectedAddress(int value) {
    _selectedAddress = value;
    notifyListeners();
  }

  set setSelectedLatLng(LatLng value) {
    _selectedLatLng = value;
  }

  set mapLatLng(LatLng value) {
    _mapLatLng = value;
  }

  Future<String> description(String language) async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        _mapLatLng!.latitude, _mapLatLng!.longitude,
        localeIdentifier: language);
    notifyListeners();
    return GetStrings().locationDescription(placemark.first);
  }

  set isoCountryCode(String value) {
    _isoCountryCode = value;
  }

  void initSelectedAddress(int value) {
    _selectedAddress = value;
    _selectedLatLng = LatLng(double.parse(_userAddress!.data![value].lat!),
        double.parse(_userAddress!.data![value].long!));
    _isoCountryCode = _userAddress!.data![value].countryIosCode!;
  }

  // user address list
  Future<void> getAddressList(String token) async {
    if (token.length > 0)
      try {
        _userAddress = await UserRepository().getAddressList(token);
      } catch (e) {
        print("catch getAddressList");
        print(e.toString());
      }
  }

  void initMapData(String languageCode) async {
    if (Platform.isAndroid)
      HMS.BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(25, 25)),
        'assets/images/pin.png',
      ).then((onValue) {
        _hmsMarker = onValue;
      });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(25, 25)),
      'assets/images/pin.png',
    ).then((onValue) {
      _myMarker = onValue;
      notifyListeners();
    });
  }

  // add new address
  Future<void> addNewAddress(BuildContext context, String accessToken) async {
    String languageCode = AppLocalizations.of(context)!.locale!.languageCode;
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (accessToken.length == 0) {
      Navigator.pop(context);
      _homeProvider.setIsLoading = true;
      if (_homeProvider.locationServiceStatus == 0 ||
          _homeProvider.locationServiceStatus == -1)
        _homeProvider.setLocationServiceStatus = 2;
      getAddressFromLatLng(languageCode, _mapLatLng!);
      List<Placemark> placemark = await placemarkFromCoordinates(
          _mapLatLng!.latitude, _mapLatLng!.longitude,
          localeIdentifier: languageCode);
      _isoCountryCode = placemark.first.isoCountryCode;
      _homeProvider.getHomePageData(false,
          latLng: _mapLatLng!, countryId: _isoCountryCode!);
    } else {
      _dialogContext = context;
      _showDialogIndicator(_dialogContext);
      var _response;
      try {
        print('a');
        List<Placemark> placemark = await placemarkFromCoordinates(
            _mapLatLng!.latitude, _mapLatLng!.longitude,
            localeIdentifier: languageCode);
        print('b');
        String comment =
            "${(descriptionController.text.length > 0 ? "${descriptionController.text}" : "${GetStrings().locationDescription(placemark.first)}")}";
        String address =
            "${(GetStrings().locationDescription(placemark.first))}";
        _isoCountryCode = placemark.first.isoCountryCode;
        print(" ${GetStrings().locationDescription(placemark.first)}");
        String _label = addressNameController.text.isNotEmpty
            ? addressNameController.text
            : comment;
        _response = await UserRepository().addAddress({
          "country_iso_code": _isoCountryCode,
          "address": address.isEmpty ? "." : address,
          "comment": comment.isEmpty ? "." : comment,
          "label": _label.isEmpty ? "." : _label,
          "is_default": "0",
          "long": "${_mapLatLng!.longitude}",
          "lat": "${_mapLatLng!.latitude}",
        }, "Bearer $accessToken");
        print("_response" + _response.body.toString());
        if (_response.statusCode == 200) {
          await getAddressList("Bearer $accessToken");
          notifyListeners();
          _selectedAddress = (_userAddress?.data?.length ?? 0) - 1;
          Navigator.pop(_dialogContext!);
          Navigator.pop(context);
          _homeProvider.setIsLoading = true;
          if (_homeProvider.locationServiceStatus == 0)
            _homeProvider.setLocationServiceStatus = 2;
          _selectedLatLng = _mapLatLng;
          _homeProvider.getHomePageData(false,
              latLng: _selectedLatLng!, countryId: _isoCountryCode!);
        } else {
          Navigator.pop(_dialogContext!);
          showSnackBar(
              context,
              _response.statusCode == 400
                  ? "region_not_supported"
                  : "unexpected_error");
        }
      } catch (e) {
        print('addNewAddress catch');
        print(e.toString());
        if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
        showSnackBar(context, "unexpected_error");
      }
    }
  }

  //update address
  Future<void> updateAddress(
      BuildContext context, String accessToken, int addressId) async {
    String languageCode = AppLocalizations.of(context)!.locale!.languageCode;
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _dialogContext = context;
    _showDialogIndicator(_dialogContext);
    var _response;
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
          _mapLatLng!.latitude, _mapLatLng!.longitude,
          localeIdentifier: languageCode);
      _isoCountryCode = placemark.first.isoCountryCode;
      String address = "${GetStrings().locationDescription(placemark.first)}";
      String comment =
          "${descriptionController.text.length > 0 ? "${descriptionController.text}" : "${GetStrings().locationDescription(placemark.first)}"}";
      _response = await UserRepository().updateAddress({
        "country_iso_code": _isoCountryCode,
        "address": address,
        "comment": comment,
        "label": addressNameController.text.isNotEmpty
            ? addressNameController.text
            : comment,
        "is_default": "0",
        "long": "${_mapLatLng!.longitude}",
        "lat": "${_mapLatLng!.latitude}",
      }, "Bearer $accessToken", "$addressId");
      print("_response" + _response.body.toString());
      if (_response.statusCode == 200) {
        int _currentLength = _userAddress!.data!.length;
        await getAddressList("Bearer $accessToken");
        notifyListeners();
        if (_userAddress!.data!.length < _currentLength) {
          _selectedAddress = (_userAddress?.data?.length ?? 0) - 1;
          _selectedLatLng = LatLng(
              double.parse(_userAddress!.data![_selectedAddress].lat!),
              double.parse(_userAddress!.data![_selectedAddress].long!));
          _isoCountryCode =
              _userAddress!.data![_selectedAddress].countryIosCode;
          _homeProvider.setIsLoading = true;
          if (_homeProvider.locationServiceStatus == 0)
            _homeProvider.setLocationServiceStatus = 2;
          _homeProvider.getHomePageData(false,
              latLng: _mapLatLng!, countryId: _isoCountryCode!);
        }
        Navigator.pop(_dialogContext!);
        Navigator.pop(context);
      } else {
        Navigator.pop(_dialogContext!);
        showSnackBar(
            context,
            _response.statusCode == 400
                ? "region_not_supported"
                : "unexpected_error");
      }
    } catch (e) {
      print(e.toString());
      if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
      showSnackBar(context, "unexpected_error");
    }
  }

  //delete address
  Future<void> deleteAddress(
      BuildContext context, String accessToken, int addressId) async {
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _dialogContext = context;
    _showDialogIndicator(_dialogContext);
    var _response;
    try {
      _response = await UserRepository()
          .deleteAddress("Bearer $accessToken", "$addressId");
      print("_response" + _response.body.toString());
      if (_response.statusCode == 200) {
        int _currentLength = _userAddress!.data!.length;
        await getAddressList("Bearer $accessToken");
        if (_userAddress!.data!.length < (_currentLength - 1)) {
          _selectedAddress = (_userAddress?.data?.length ?? 0) - 1;
          _selectedLatLng = LatLng(
              double.parse(_userAddress!.data![_selectedAddress].lat!),
              double.parse(_userAddress!.data![_selectedAddress].long!));
          _isoCountryCode =
              _userAddress!.data![_selectedAddress].countryIosCode;
          _homeProvider.setIsLoading = true;
          notifyListeners();

          if (_homeProvider.locationServiceStatus == 0)
            _homeProvider.setLocationServiceStatus = 2;
          _homeProvider.getHomePageData(false,
              latLng: _mapLatLng!, countryId: _isoCountryCode!);
        } else {
          _selectedAddress = (_userAddress?.data?.length ?? 0) - 1;
        }
        Navigator.pop(_dialogContext!);
      } else {
        Navigator.pop(_dialogContext!);
        showSnackBar(context, "unexpected_error");
      }
    } catch (e) {
      print(e.toString());
      if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
      showSnackBar(context, "unexpected_error");
    }
    notifyListeners();
  }

  // show indicator dialog
  void _showDialogIndicator(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dialogContext = context;
          return IndicatorDialog();
        });
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      AppLocalizations.of(context)!.tr(msg),
      textAlign: TextAlign.center,
    )));
  }

  // Converting Latitude and Longitude to a Human-readable Address
  getAddressFromLatLng(String languageCode, LatLng latLng) async {
    try {
      print(latLng);
      if (latLng == LatLng(24.727726176454684, 46.58666208381939))
        _addressDescription = "";
      List<Placemark> placemark = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: languageCode);
      Placemark place = placemark.first;
      _isoCountryCode = place.isoCountryCode;
      _addressDescription = GetStrings().locationDescription(place);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
