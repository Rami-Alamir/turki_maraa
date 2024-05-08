import 'package:flutter/material.dart';
import 'package:huawei_map/huawei_map.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gms;
import 'package:location/location.dart' as location_service;
import 'package:huawei_map/huawei_map.dart' as hms;
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import '../../widgets/map/map_bottom_sheet.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/hms_latlng_converter.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/utilities/locals_values.dart';
import '../../../models/user_address.dart';

class HMSMap extends StatefulWidget {
  final int addressIndex;

  const HMSMap({super.key, this.addressIndex = -100});
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
  Uint8List? markerIcon;

  @override
  void initState() {
    HuaweiMapInitializer.initializeMap();
    Future.delayed(const Duration(seconds: 0), () async {
      await addCustomIcon();
    });
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
        final Locale systemLocales = View.of(context).platformDispatcher.locale;
        String localsIsoCountryCode = systemLocales.countryCode ?? "SA";
        String isoCountryCode =
            sl<LocalsValues>().getCountryCode(localsIsoCountryCode);
        addressProvider.mapLatLng =
            sl<LocalsValues>().getGMSLatLng(isoCountryCode);
      }
    }
    super.initState();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> addCustomIcon() async {
    markerIcon = await getBytesFromAsset(FixedAssets.mapPin, 100);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (_, addressProvider, __) {
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
              if (markerIcon != null)
                hms.Marker(
                  onDragEnd: (latLng) {
                    setState(() {
                      addressProvider.mapLatLng =
                          _hmsLatLngConverter.convertToGMSLatLng2(latLng);
                    });
                  },
                  draggable: true,
                  markerId: const hms.MarkerId("1"),
                  position: HMSLatLngConverter()
                      .convertToHMSLatLng(addressProvider.mapLatLng),
                  icon: hms.BitmapDescriptor.fromBytes(markerIcon!),
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
    });
  }

  void _onMapCreated(hms.HuaweiMapController cntlr) {
    try {
      final AddressProvider addressProvider =
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
