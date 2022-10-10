import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '/../core/utilities/get_strings.dart';
import '/../core/utilities/show_snack_bar.dart';
import '/../models/user_address.dart';
import '/../presentation/widgets/dialog/indicator_dialog.dart';
import '/../repository/user_repository.dart';
import '/../core/utilities/app_localizations.dart';
import '/../core/utilities/show_dialog.dart';
import 'location_provider.dart';
import 'package:huawei_map/map.dart' as hms;
import 'package:http/http.dart' as http;

class AddressProvider with ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();

  // -1 mean current location selected
  int _selectedAddress = -1;
  bool? _isAuth;
  UserAddress? _userAddress;
  LatLng? _mapLatLng;
  String? _authorization;
  BuildContext? _dialogContext;
  BitmapDescriptor? _myMarker;
  hms.BitmapDescriptor? _hmsMarker;
  bool? _initMap = false;
  hms.BitmapDescriptor? get hmsMarker => _hmsMarker;
  BitmapDescriptor? get myMarker => _myMarker;
  UserAddress? get userAddress => _userAddress;
  LatLng get mapLatLng =>
      _mapLatLng ?? const LatLng(24.727726176454684, 46.58666208381939);
  int get selectedAddress => _selectedAddress;
  bool get initMap => _initMap!;

  set mapLatLng(LatLng value) {
    _mapLatLng = value;
  }

  set initMap(bool value) {
    _initMap = value;
  }

  set selectedAddress(int value) {
    _selectedAddress = value;
    notifyListeners();
  }

  void updateAddressProvider(bool isAuth, String accessToken) {
    _isAuth = isAuth;
    _authorization = "Bearer $accessToken";

    if (_isAuth == true && _userAddress == null) {
      getAddressList();
    } else if (_isAuth == false) {
      _userAddress = null;
      _selectedAddress = -1;
    }
  }

  // user address list
  Future<void> getAddressList() async {
    if (_isAuth ?? false) {
      try {
        _userAddress = await UserRepository().getAddressList(_authorization!);
      } catch (_) {}
    }
  }

  // add new address
  Future<void> addNewAddress(BuildContext context,
      {LatLng? latLng, String? isoCountryCode}) async {
    String languageCode = AppLocalizations.of(context)!.locale!.languageCode;
    _dialogContext = context;
    if (latLng == null && (_isAuth ?? false)) {
      _showDialogIndicator(_dialogContext);
    }
    http.Response response;
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
          latLng?.latitude ?? _mapLatLng!.latitude,
          latLng?.longitude ?? _mapLatLng!.longitude,
          localeIdentifier: languageCode);
      String address = GetStrings().locationDescription(placemark.first);
      String comment = descriptionController.text.isNotEmpty
          ? descriptionController.text
          : GetStrings().locationDescription(placemark.first);
      String countryCode = placemark.first.isoCountryCode!;
      if (_isAuth ?? false) {
        response = await UserRepository().addAddress({
          "country_iso_code": isoCountryCode ?? countryCode,
          "address": address,
          "comment": comment,
          "label": addressNameController.text.isNotEmpty
              ? addressNameController.text
              : comment,
          "is_default": "0",
          "long": "${latLng?.longitude ?? _mapLatLng!.longitude}",
          "lat": "${latLng?.latitude ?? _mapLatLng!.latitude}",
        }, _authorization!);
        if (response.statusCode == 200) {
          _selectedAddress = _userAddress!.data!.length;
          await getAddressList();
          final locationProvider =
              // ignore: use_build_context_synchronously
              Provider.of<LocationProvider>(context, listen: false);
          locationProvider.updateLocationData(
              _userAddress!.data![_selectedAddress].countryIosCode!,
              LatLng(double.parse(_userAddress!.data![_selectedAddress].lat!),
                  double.parse(_userAddress!.data![_selectedAddress].long!)));
          if (latLng == null) {
            notifyListeners();
            Navigator.pop(_dialogContext!);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        } else {
          if (latLng == null) Navigator.pop(_dialogContext!);
          // ignore: use_build_context_synchronously
          ShowSnackBar().show(
              context,
              response.statusCode == 400
                  ? "region_not_supported"
                  : "unexpected_error");
        }
      } else {
        final locationProvider =
            // ignore: use_build_context_synchronously
            Provider.of<LocationProvider>(context, listen: false);
        locationProvider.updateLocationData(countryCode, _mapLatLng!);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } catch (e) {
      if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
      ShowSnackBar().show(context, "unexpected_error");
    }
  }

  //update address
  Future<void> updateAddress(BuildContext context, int addressId) async {
    String languageCode = AppLocalizations.of(context)!.locale!.languageCode;
    _dialogContext = context;
    _showDialogIndicator(_dialogContext);
    // ignore: prefer_typing_uninitialized_variables
    var response;
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
          _mapLatLng!.latitude, _mapLatLng!.longitude,
          localeIdentifier: languageCode);
      String address = GetStrings().locationDescription(placemark.first);
      String comment = descriptionController.text.isNotEmpty
          ? descriptionController.text
          : GetStrings().locationDescription(placemark.first);
      response = await UserRepository().updateAddress({
        "country_iso_code": placemark.first.isoCountryCode,
        "address": address,
        "comment": comment,
        "label": addressNameController.text.isNotEmpty
            ? addressNameController.text
            : comment,
        "is_default": "0",
        "long": "${_mapLatLng!.longitude}",
        "lat": "${_mapLatLng!.latitude}",
      }, _authorization!, "$addressId");
      if (response.statusCode == 200) {
        await getAddressList();
        notifyListeners();
        Navigator.pop(_dialogContext!);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        Navigator.pop(_dialogContext!);
        // ignore: use_build_context_synchronously
        ShowSnackBar().show(context,
            response == 400 ? "region_not_supported" : "unexpected_error");
      }
    } catch (e) {
      if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
      ShowSnackBar().show(context, "unexpected_error");
    }
  }

  //delete address
  Future<void> deleteAddress(BuildContext context, int addressId) async {
    ShowConfirmDialog().confirmDialog(context, () async {
      _dialogContext = context;
      _showDialogIndicator(_dialogContext);
      http.Response response;
      try {
        response =
            await UserRepository().deleteAddress(_authorization!, "$addressId");
        if (response.statusCode == 200) {
          await getAddressList();
          notifyListeners();
          Navigator.pop(_dialogContext!);
        } else {
          Navigator.pop(_dialogContext!);
          // ignore: use_build_context_synchronously
          ShowSnackBar().show(context, "unexpected_error");
        }
      } catch (e) {
        if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
        ShowSnackBar().show(context, "unexpected_error");
      }
      notifyListeners();
    }, "are_you_sure_you_want_to_delete_the_address", "delete_address",
        icon: 'assets/images/profile_icons/home-location.svg');
  }

  // show indicator dialog
  void _showDialogIndicator(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dialogContext = context;
          return const IndicatorDialog();
        });
  }

  void initMapMarker() async {
    if (Platform.isAndroid) {
      hms.BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(25, 25)),
        'assets/images/pin.png',
      ).then((onValue) {
        _hmsMarker = onValue;
      });
    }
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      'assets/images/pin.png',
    ).then((onValue) {
      _myMarker = onValue;
      notifyListeners();
    });
  }

  Future<String> description(String language) async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        _mapLatLng!.latitude, _mapLatLng!.longitude,
        localeIdentifier: language);
    notifyListeners();
    return GetStrings().locationDescription(placemark.first);
  }
}
