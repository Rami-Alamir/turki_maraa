import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gms;
import 'package:huawei_map/channel/huaweiMapInitializer.dart';
import 'package:location/location.dart' as location_service;
import 'package:huawei_map/map.dart' as hms;
import '../../../core/service/service_locator.dart';
import '../../../models/user_address.dart';
import '../../../controllers/address_provider.dart';
import '../../../core/utilities/hms_latlng_converter.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/shared/map_bottom_sheet.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/utilities/locals_values.dart';

class HMSMap extends StatefulWidget {
  final int addressIndex;

  const HMSMap({Key? key, this.addressIndex = -100}) : super(key: key);
  @override
  HMSMapState createState() => HMSMapState();
}

class HMSMapState extends State<HMSMap> {
  hms.HuaweiMapController? _controller;
  location_service.Location? _location;
  Data? _userAddress;
  bool _showBottomSheet = false;
  String _addressDescription = '';
  final HMSLatLngConverter _hmsLatLngConverter = sl<HMSLatLngConverter>();
  @override
  void initState() {
    HuaweiMapInitializer.initializeMap();
    final AddressProvider addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    addressProvider.addressNameController.clear();
    addressProvider.descriptionController.clear();
    if (widget.addressIndex != -100) {
      _userAddress = addressProvider.userAddress!.data![widget.addressIndex];
      addressProvider.mapLatLng = gms.LatLng(
          double.parse(_userAddress!.lat!), double.parse(_userAddress!.long!));
      addressProvider.addressNameController.text = _userAddress!.label!;
      addressProvider.descriptionController.text = _userAddress!.comment!;
    } else {
      final LocationProvider locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      if (locationProvider.latLng != null) {
        addressProvider.mapLatLng = locationProvider.latLng!;
      } else {
        final List<Locale> systemLocales =
            WidgetsBinding.instance.window.locales;
        String localsIsoCountryCode = systemLocales.first.countryCode ?? "SA";
        String isoCountryCode =
            sl<LocalsValues>().getCountryCode(localsIsoCountryCode);
        addressProvider.mapLatLng =
            sl<LocalsValues>().getGMSLatLng(isoCountryCode);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AddressProvider addressProvider =
        Provider.of<AddressProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr("choose_delivery_location"),
      ),
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: hms.HuaweiMap(
          minMaxZoomPreference: hms.MinMaxZoomPreference.unbounded,
          markers: <hms.Marker>{
            hms.Marker(
              onDragEnd: (latLng) {
                setState(() {
                  addressProvider.mapLatLng =
                      _hmsLatLngConverter.convertToGMSLatLng2(latLng);
                });
              },
              draggable: true,
              markerId: hms.MarkerId("1"),
              position: HMSLatLngConverter()
                  .convertToHMSLatLng(addressProvider.mapLatLng),
              icon: addressProvider.hmsMarker!,
            )
          },
          buildingsEnabled: true,
          initialCameraPosition: hms.CameraPosition(
            target: _hmsLatLngConverter
                .convertToHMSLatLng(addressProvider.mapLatLng),
            zoom: 17.5,
          ),
          mapType: hms.MapType.normal,
          compassEnabled: true,
          onMapCreated: _onMapCreated,
          onCameraMove: (latLng) {
            _showBottomSheet = false;
            addressProvider.mapLatLng =
                _hmsLatLngConverter.convertToGMSLatLng2(latLng.target);
            setState(() {});
          },
          onClick: (latLng) {
            _showBottomSheet = false;
            addressProvider.mapLatLng =
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
                    _addressDescription = await addressProvider.description(
                        AppLocalizations.of(context)!.locale!.languageCode);
                  },
                ),
              ],
            ),
    );
  }

  void _onMapCreated(hms.HuaweiMapController cntlr) {
    try {
      final addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      _controller = cntlr;

      _location!.onLocationChanged.listen((l) {
        if (!addressProvider.initMap) {
          addressProvider.mapLatLng = gms.LatLng(l.latitude!, l.longitude!);
          addressProvider.initMap = true;
          setState(() {});
        }
        _controller!.animateCamera(
          hms.CameraUpdate.newCameraPosition(
            hms.CameraPosition(
              target: _hmsLatLngConverter
                  .convertToHMSLatLng(addressProvider.mapLatLng),
              zoom: 0,
            ),
          ),
        );
      });
    } catch (_) {}
  }
}
