import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/models/user_address.dart';
import 'package:new_turki/repository/user_repository.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';
import 'package:provider/provider.dart';
import 'home_provider.dart';

class AddressProvider with ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();
  BitmapDescriptor? _myMarker;
  String? _addressDescription;
  LatLng? _latLng;
  bool? _initMap = false;
  UserAddress? _userAddress;
  BuildContext? _dialogContext;
  int _selectedAddress = -1;
  String? _isoCountryCode = 'SA';

  int get selectedAddress => _selectedAddress;
  bool get initMap => _initMap!;
  UserAddress? get userAddress => _userAddress;
  LatLng get latLng => _latLng ?? LatLng(24.727726176454684, 46.58666208381939);
  BitmapDescriptor? get myMarker => _myMarker;
  String? get addressDescription => _addressDescription;
  String get isoCountryCode => _isoCountryCode!;

  set initMap(bool value) {
    _initMap = value;
  }

  void clearDescription() {
    _latLng = null;
    _addressDescription = null;
  }

  set setUserAddress(UserAddress value) {
    _userAddress = value;
  }

  set setSelectedAddress(int value) {
    _selectedAddress = value;
    notifyListeners();
  }

  set latLng(LatLng value) {
    _latLng = value;
  }

  set isoCountryCode(String value) {
    _isoCountryCode = value;
  }

  void initSelectedAddress(int value) {
    _selectedAddress = value;
    _latLng = LatLng(double.parse(_userAddress!.data![value].lat!),
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
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(25, 25)), 'assets/images/pin.png')
        .then((onValue) {
      _myMarker = onValue;
      notifyListeners();
    });
    getAddressFromLatLng(languageCode);
  }

  // add new address
  Future<void> addNewAddress(BuildContext context, String accessToken) async {
    String languageCode = AppLocalizations.of(context)!.locale!.languageCode;
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    print("ccessToken.length == 0${accessToken.length == 0}");
    if (accessToken.length == 0) {
      Navigator.pop(context);
      _homeProvider.setIsLoading = true;
      if (_homeProvider.locationServiceStatus == 0 ||
          _homeProvider.locationServiceStatus == -1)
        _homeProvider.setLocationServiceStatus = 2;
      getAddressFromLatLng(languageCode);
      List<Placemark> placemark = await placemarkFromCoordinates(
          _latLng!.latitude, _latLng!.longitude,
          localeIdentifier: languageCode);
      _isoCountryCode = placemark.first.isoCountryCode;
      _homeProvider.getHomePageData(false,
          latLng: _latLng!, countryId: _isoCountryCode!);
    } else {
      _dialogContext = context;
      _showDialogIndicator(_dialogContext);
      var _response;
      try {
        List<Placemark> placemark = await placemarkFromCoordinates(
            _latLng!.latitude, _latLng!.longitude,
            localeIdentifier: languageCode);
        _isoCountryCode = placemark.first.isoCountryCode;
        _response = await UserRepository().addAddress({
          "country_iso_code": _isoCountryCode,
          "address":
              "${descriptionController.text.length > 0 ? "${descriptionController.text}" : "${Platform.isAndroid ? placemark.first.postalCode : placemark.first.street} - ${placemark.first.subLocality} "} ",
          "comment":
              "${descriptionController.text.length > 0 ? "${descriptionController.text}" : "."} ",
          "label": "label",
          "is_default": "0",
          "long": "${latLng.longitude}",
          "lat": "${latLng.latitude}",
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

          _homeProvider.getHomePageData(false,
              latLng: _latLng!, countryId: _isoCountryCode!);
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
  getAddressFromLatLng(String languageCode) async {
    try {
      print(_latLng);
      if (_latLng == LatLng(24.727726176454684, 46.58666208381939))
        _addressDescription = "";
      print('getAddressFromLatLng');
      List<Placemark> placemark = await placemarkFromCoordinates(
          _latLng!.latitude, _latLng!.longitude,
          localeIdentifier: languageCode);
      Placemark place = placemark.first;
      _isoCountryCode = place.isoCountryCode;
      if (Platform.isAndroid)
        _addressDescription = "${place.postalCode} - ${place.subLocality}";
      else
        _addressDescription = "${place.street} - ${place.subLocality} ";
      print('getAddressFromLatLng');
      if (_addressDescription == " -  ")
        _addressDescription = "${place.postalCode} - ${place.name}";
      print(_addressDescription);
      print("_addressDescription");
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
