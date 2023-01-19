import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:huawei_map/map.dart' as hms;
import 'package:http/http.dart' as http;
import '../core/utilities/dialog_helper.dart';
import '../core/constants/fixed_assets.dart';
import '../core/service/service_locator.dart';
import '/../core/utilities/get_strings.dart';
import '/../core/utilities/show_snack_bar.dart';
import '/../core/utilities/app_localizations.dart';
import '/../models/user_address.dart';
import '/../repository/user_repository.dart';

class AddressProvider with ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();

  // -1 mean current location selected
  int _selectedAddress = -1;
  bool? _isAuth;
  UserAddress? _userAddress;
  LatLng? _mapLatLng;
  String? _mapCountryCode;
  String? _authorization;
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
  String? get mapCountryCode => _mapCountryCode;

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

  Future<void> getAddressList() async {
    if (_isAuth ?? false) {
      try {
        _userAddress =
            await sl<UserRepository>().getAddressList(_authorization!);
      } catch (_) {}
    }
  }

  Future<int> addNewAddress(BuildContext context,
      {LatLng? latLng,
      String? isoCountryCode,
      bool showIndicatorDialog = true}) async {
    String languageCode = AppLocalizations.of(context)!.locale!.languageCode;
    if (latLng == null && (_isAuth ?? false) && showIndicatorDialog) {
      sl<DialogHelper>().showIndicatorDialog(context);
    }
    http.Response response;
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
          latLng?.latitude ?? _mapLatLng!.latitude,
          latLng?.longitude ?? _mapLatLng!.longitude,
          localeIdentifier: languageCode);
      String address = sl<GetStrings>().locationDescription(placemark.first);
      String comment = descriptionController.text.isNotEmpty
          ? descriptionController.text
          : sl<GetStrings>().locationDescription(placemark.first);
      _mapCountryCode = placemark.first.isoCountryCode!;
      if (_isAuth ?? false) {
        response = await sl<UserRepository>().addAddress({
          "country_iso_code": isoCountryCode ?? _mapCountryCode,
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
        }
        return response.statusCode;
      } else {
        _selectedAddress = -2;
        return 1;
      }
    } catch (_) {}
    return 0;
  }

  // Future<void> addNewAddress(BuildContext context,
  //     {LatLng? latLng, String? isoCountryCode}) async {
  //   String languageCode = AppLocalizations.of(context)!.locale!.languageCode;
  //   _dialogContext = context;
  //   if (latLng == null && (_isAuth ?? false)) {
  //     _showDialogIndicator(_dialogContext);
  //   }
  //   http.Response response;
  //   try {
  //     List<Placemark> placemark = await placemarkFromCoordinates(
  //         latLng?.latitude ?? _mapLatLng!.latitude,
  //         latLng?.longitude ?? _mapLatLng!.longitude,
  //         localeIdentifier: languageCode);
  //     String address = sl<GetStrings>().locationDescription(placemark.first);
  //     String comment = descriptionController.text.isNotEmpty
  //         ? descriptionController.text
  //         : sl<GetStrings>().locationDescription(placemark.first);
  //     String countryCode = placemark.first.isoCountryCode!;
  //     if (_isAuth ?? false) {
  //       response = await sl<UserRepository>().addAddress({
  //         "country_iso_code": isoCountryCode ?? countryCode,
  //         "address": address,
  //         "comment": comment,
  //         "label": addressNameController.text.isNotEmpty
  //             ? addressNameController.text
  //             : comment,
  //         "is_default": "0",
  //         "long": "${latLng?.longitude ?? _mapLatLng!.longitude}",
  //         "lat": "${latLng?.latitude ?? _mapLatLng!.latitude}",
  //       }, _authorization!);
  //       if (response.statusCode == 200) {
  //         _selectedAddress = _userAddress!.data!.length;
  //         await getAddressList();
  //         final locationProvider =
  //             // ignore: use_build_context_synchronously
  //             Provider.of<LocationProvider>(context, listen: false);
  //         locationProvider.updateLocationData(
  //             _userAddress!.data![_selectedAddress].countryIosCode!,
  //             LatLng(double.parse(_userAddress!.data![_selectedAddress].lat!),
  //                 double.parse(_userAddress!.data![_selectedAddress].long!)));
  //         if (latLng == null) {
  //           notifyListeners();
  //           Navigator.pop(_dialogContext!);
  //           // ignore: use_build_context_synchronously
  //           Navigator.pop(context);
  //         }
  //       } else {
  //         if (latLng == null) Navigator.pop(_dialogContext!);
  //         // ignore: use_build_context_synchronously
  //         sl<ShowSnackBar>().show(
  //             context,
  //             response.statusCode == 400
  //                 ? "region_not_supported"
  //                 : "unexpected_error");
  //       }
  //     } else {
  //       final locationProvider =
  //           // ignore: use_build_context_synchronously
  //           Provider.of<LocationProvider>(context, listen: false);
  //       locationProvider.updateLocationData(countryCode, _mapLatLng!);
  //       // ignore: use_build_context_synchronously
  //       Navigator.pop(context);
  //     }
  //   } catch (_) {
  //     if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
  //     sl<ShowSnackBar>().show(context, "unexpected_error");
  //   }
  // }

  Future<int> updateAddress(BuildContext context, int addressId) async {
    String languageCode = AppLocalizations.of(context)!.locale!.languageCode;
    sl<DialogHelper>().showIndicatorDialog(context);
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
          _mapLatLng!.latitude, _mapLatLng!.longitude,
          localeIdentifier: languageCode);
      String address = sl<GetStrings>().locationDescription(placemark.first);
      String comment = descriptionController.text.isNotEmpty
          ? descriptionController.text
          : sl<GetStrings>().locationDescription(placemark.first);
      var response = await sl<UserRepository>().updateAddress({
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
      }
      return response.statusCode;
    } catch (_) {}
    return 0;
  }

  // Future<void> updateAddress(BuildContext context, int addressId) async {
  //   String languageCode = AppLocalizations.of(context)!.locale!.languageCode;
  //   _dialogContext = context;
  //   _showDialogIndicator(_dialogContext);
  //   // ignore: prefer_typing_uninitialized_variables
  //   var response;
  //   try {
  //     List<Placemark> placemark = await placemarkFromCoordinates(
  //         _mapLatLng!.latitude, _mapLatLng!.longitude,
  //         localeIdentifier: languageCode);
  //     String address = sl<GetStrings>().locationDescription(placemark.first);
  //     String comment = descriptionController.text.isNotEmpty
  //         ? descriptionController.text
  //         : sl<GetStrings>().locationDescription(placemark.first);
  //     response = await sl<UserRepository>().updateAddress({
  //       "country_iso_code": placemark.first.isoCountryCode,
  //       "address": address,
  //       "comment": comment,
  //       "label": addressNameController.text.isNotEmpty
  //           ? addressNameController.text
  //           : comment,
  //       "is_default": "0",
  //       "long": "${_mapLatLng!.longitude}",
  //       "lat": "${_mapLatLng!.latitude}",
  //     }, _authorization!, "$addressId");
  //     if (response.statusCode == 200) {
  //       await getAddressList();
  //       notifyListeners();
  //       Navigator.pop(_dialogContext!);
  //       // ignore: use_build_context_synchronously
  //       Navigator.pop(context);
  //     } else {
  //       Navigator.pop(_dialogContext!);
  //       // ignore: use_build_context_synchronously
  //       sl<ShowSnackBar>().show(context,
  //           response == 400 ? "region_not_supported" : "unexpected_error");
  //     }
  //   } catch (_) {
  //     if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
  //     sl<ShowSnackBar>().show(context, "unexpected_error");
  //   }
  // }

  Future<int> deleteAddress(
      BuildContext context, int addressId, int index) async {
    if (index == _selectedAddress) {
      sl<ShowSnackBar>().show(
          context, "the_address_used_as_a_delivery_address_cannot_be_deleted");
      return 1;
    } else {
      try {
        sl<DialogHelper>().showIndicatorDialog(context);
        var response =
            await UserRepository().deleteAddress(_authorization!, "$addressId");
        if (response.statusCode == 200) {
          await getAddressList();
        }
      } catch (_) {
        return 0;
      }
      notifyListeners();
      return 2;
    }
  }

  void initMapMarker() async {
    if (Platform.isAndroid) {
      hms.BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(25, 25)),
        FixedAssets.mapPin,
      ).then((onValue) {
        _hmsMarker = onValue;
      });
    }
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      FixedAssets.mapPin,
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
    return sl<GetStrings>().locationDescription(placemark.first);
  }
}
