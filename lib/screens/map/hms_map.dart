import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GMS;
import 'package:huawei_map/channel/huaweiMapInitializer.dart';
import 'package:location/location.dart' as Location;
import 'package:huawei_map/map.dart' as HMS;
import '../../../models/user_address.dart';
import '../../../provider/address_provider.dart';
import '../../../utilities/HMS_latlng_converter.dart';
import '../../../utilities/app_localizations.dart';
import '../../../utilities/size_config.dart';
import '../../../widgets/shared/primary_app_bar.dart';
import '../../../widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/shared/map_bottom_sheet.dart';

class HMSMap extends StatefulWidget {
  final int addressIndex;

  const HMSMap({this.addressIndex = -100});
  @override
  _HMSMapState createState() => _HMSMapState();
}

class _HMSMapState extends State<HMSMap> {
  HMS.HuaweiMapController? _controller;
  Location.Location? _location;
  Data? _userAddress;
  bool _showBottomSheet = false;
  String _addressDescription = '';
  HMSLatLngConverter _hmsLatLngConverter = HMSLatLngConverter();
  @override
  void initState() {
    HuaweiMapInitializer.initializeMap();

    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    _addressProvider.addressNameController.clear();
    _addressProvider.descriptionController.clear();
    if (widget.addressIndex != -100) {
      final _addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      _userAddress = _addressProvider.userAddress!.data![widget.addressIndex];
      _addressProvider.mapLatLng = GMS.LatLng(
          double.parse(_userAddress!.lat!), double.parse(_userAddress!.long!));
      _addressProvider.descriptionController.text = _userAddress!.comment!;
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
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: HMS.HuaweiMap(
          minMaxZoomPreference: HMS.MinMaxZoomPreference.unbounded,
          markers: Set<HMS.Marker>.of(
            <HMS.Marker>[
              HMS.Marker(
                onDragEnd: (latLng) {
                  setState(() {
                    _addressProvider.mapLatLng =
                        _hmsLatLngConverter.convertToGMSLatLng2(latLng);
                  });
                },
                draggable: true,
                markerId: HMS.MarkerId("1"),
                position: HMSLatLngConverter()
                    .convertToHMSLatLng(_addressProvider.mapLatLng),
                icon: _addressProvider.hmsMarker!,
              )
            ],
          ),
          buildingsEnabled: true,
          initialCameraPosition: HMS.CameraPosition(
            target: _hmsLatLngConverter
                .convertToHMSLatLng(_addressProvider.mapLatLng),
            zoom: 17.5,
          ),
          mapType: HMS.MapType.normal,
          compassEnabled: true,
          onMapCreated: _onMapCreated,
          onCameraMove: (latLng) {
            _showBottomSheet = false;
            _addressProvider.mapLatLng =
                _hmsLatLngConverter.convertToGMSLatLng2(latLng.target);
            setState(() {});
          },
          onClick: (latLng) {
            _showBottomSheet = false;
            _addressProvider.mapLatLng =
                _hmsLatLngConverter.convertToGMSLatLng2(latLng);
            setState(() {});
          },
          myLocationButtonEnabled: true,
        ),
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
    );
  }

  void _onMapCreated(HMS.HuaweiMapController _cntlr) {
    try {
      final _addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      _controller = _cntlr;

      _location!.onLocationChanged.listen((l) {
        if (!_addressProvider.initMap) {
          _addressProvider.mapLatLng = GMS.LatLng(l.latitude!, l.longitude!);
          _addressProvider.initMap = true;
          setState(() {});
        }
        _controller!.animateCamera(
          HMS.CameraUpdate.newCameraPosition(
            HMS.CameraPosition(
              target: _hmsLatLngConverter
                  .convertToHMSLatLng(_addressProvider.mapLatLng),
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
