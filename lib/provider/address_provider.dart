import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:new_turki/models/user_address.dart';
import 'package:new_turki/repository/user_repository.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';

class AddressProvider with ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();
  BitmapDescriptor? _myMarker;
  LatLng? _latLng;
  bool? _initMap = false;
  UserAddress? _userAddress;
  BuildContext? _dialogContext;
  int _selectedAddress = -1;
  int get selectedAddress => _selectedAddress;
  bool get initMap => _initMap!;
  UserAddress? get userAddress => _userAddress;
  LatLng get latLng => _latLng ?? LatLng(0, 0);
  BitmapDescriptor get myMarker => _myMarker!;

  set initMap(bool value) {
    _initMap = value;
  }

  set setUserAddress(UserAddress value) {
    _userAddress = value;
  }

  set setSelectedAddress(int value) {
    _selectedAddress = value;
  }

  set latLng(LatLng value) {
    _latLng = value;
    print(value.toString());
  }

  // user address list
  Future<void> getAddressList(String token) async {
    if (token.length > 0)
      try {
        _userAddress = await UserRepository().getAddressList(token);
      } catch (e) {
        print(e.toString());
        //  _retry = true;
      }
  }

  //get user location + init marker
  void initMapData() async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(25, 25)), 'assets/images/pin.png')
        .then((onValue) {
      _myMarker = onValue;
      notifyListeners();
    });
    LocationData _locationData = await Location().getLocation();
    _latLng = LatLng(_locationData.latitude!, _locationData.longitude!);
  }

  // add new address
  Future<void> addNewAddress(BuildContext context, String accessToken) async {
    if (accessToken.length == 0) {
      Navigator.pop(context);
    } else {
      _dialogContext = context;
      _showDialogIndicator(_dialogContext);
      var _response;
      try {
        _response = await UserRepository().addAddress({
          "country_id": "1",
          "city_id": "2",
          "address":
              "${descriptionController.text.length > 0 ? "${descriptionController.text}" : "."} ",
          "comment":
              "${descriptionController.text.length > 0 ? "${descriptionController.text}" : "."} ",
          "label": "label",
          "is_default": "0",
          "long": "${latLng.latitude}",
          "lat": "${latLng.longitude}",
        }, "Bearer $accessToken");
        print(_response.body.toString());

        if (_response.statusCode == 200) {
          // showSnackBar(context, 'data_has_been_updated_successfully');
          // AlertController.show(
          //     " ",
          //     AppLocalizations.of(context)!
          //         .tr('data_has_been_updated_successfully'),
          //     TypeAlert.success);
          await getAddressList("Bearer $accessToken");
          notifyListeners();
          Navigator.pop(_dialogContext!);
          Navigator.pop(context);
        } else {
          Navigator.pop(_dialogContext!);
          showSnackBar(context, "unexpected_error");

          // AlertController.show(
          //     "",
          //     AppLocalizations.of(context)!.tr(_response.statusCode == 400
          //         ? "please_enter_your_name"
          //         : "unexpected_error"),
          //     TypeAlert.error);
        }
      } catch (e) {
        print('catch');
        print(e.toString());
        if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
        showSnackBar(context, "unexpected_error");
        // AlertController.show(
        //     "",
        //     AppLocalizations.of(context)!.tr("unexpected_error"),
        //     TypeAlert.error);
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
}
