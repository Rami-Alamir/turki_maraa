import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:new_turki/models/user_address.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/map_bottom_sheet.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:provider/provider.dart';

import '../../widgets/shared/rounded_rectangle_button.dart';

class SelectAddress extends StatefulWidget {
  final int addressIndex;

  const SelectAddress({this.addressIndex = -100});
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  GoogleMapController? _controller;
  Location? _location;
  Data? _userAddress;
  String _addressDescription = '';
  bool _showBottomSheet = false;
  @override
  void initState() {
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    if (widget.addressIndex != -100) {
      _userAddress = _addressProvider.userAddress!.data![widget.addressIndex];
      _addressProvider.mapLatLng = LatLng(
          double.parse(_userAddress!.lat!), double.parse(_userAddress!.long!));
      _addressProvider.descriptionController.text = _userAddress!.comment!;
      _addressProvider.addressNameController.text = _userAddress!.label!;
    } else {
      _addressProvider.descriptionController.clear();
      _addressProvider.addressNameController.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _addressProvider = Provider.of<AddressProvider>(context);

    return Scaffold(
      extendBody: true,
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr("choose_delivery_location"),
      ),
      bottomSheet: _showBottomSheet
          ? MapBottomSheet(
              addressIndex: widget.addressIndex,
              userAddressId: _userAddress?.id ?? 0,
              addressDescription: _addressDescription)
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedRectangleButton(
                  title: AppLocalizations.of(context)!.tr('confirm_location'),
                  fontSize: 16.0,
                  width: SizeConfig.screenWidth! * 0.9,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  onPressed: () async {
                    _showBottomSheet = true;
                    setState(() {});
                    _addressDescription = await _addressProvider.description(
                        AppLocalizations.of(context)!.locale!.languageCode);
                  },
                ),
              ],
            ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: GoogleMap(
          layoutDirection:
              AppLocalizations.of(context)!.locale!.languageCode == "ar"
                  ? TextDirection.rtl
                  : TextDirection.ltr,
          minMaxZoomPreference: MinMaxZoomPreference.unbounded,
          markers: Set<Marker>.of(
            <Marker>[
              Marker(
                onDragEnd: (latLng) {
                  setState(() {
                    _addressProvider.mapLatLng = latLng;
                    _showBottomSheet = false;
                  });
                },
                draggable: true,
                markerId: MarkerId("1"),
                position: _addressProvider.mapLatLng,
                icon: _addressProvider.myMarker!,
                infoWindow: const InfoWindow(
                  title: '',
                ),
              )
            ],
          ),
          initialCameraPosition: CameraPosition(
            target: _addressProvider.mapLatLng,
            zoom: widget.addressIndex == -100 ? 15.3 : 17.5,
          ),
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          onCameraMove: (latLng) {
            _showBottomSheet = false;

            _addressProvider.mapLatLng = latLng.target;
            setState(() {});
          },
          onTap: (latLng) {
            _showBottomSheet = false;

            _addressProvider.mapLatLng = latLng;
            setState(() {});
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    try {
      final _addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      _controller = _cntlr;
      _location!.onLocationChanged.listen((l) {
        if (!_addressProvider.initMap) {
          _addressProvider.mapLatLng = LatLng(l.latitude!, l.longitude!);
          _addressProvider.initMap = true;
          setState(() {});
        }
        _controller!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _addressProvider.mapLatLng,
              zoom: 0,
            ),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
