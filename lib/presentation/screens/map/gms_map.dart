import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../core/service/service_locator.dart';
import '../../../models/user_address.dart';
import '../../../controllers/address_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/shared/map_bottom_sheet.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/utilities/locals_values.dart';

class GMSMap extends StatefulWidget {
  final int addressIndex;

  const GMSMap({Key? key, this.addressIndex = -100}) : super(key: key);
  @override
  GMSMapState createState() => GMSMapState();
}

class GMSMapState extends State<GMSMap> {
  GoogleMapController? _controller;
  Location? _location;
  Data? _userAddress;
  bool _showBottomSheet = false;
  String _addressDescription = '';

  @override
  void initState() {
    final AddressProvider addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    addressProvider.addressNameController.clear();
    addressProvider.descriptionController.clear();
    //init map LatLng
    if (widget.addressIndex != -100) {
      _userAddress = addressProvider.userAddress!.data![widget.addressIndex];
      addressProvider.mapLatLng = LatLng(
          double.parse(_userAddress!.lat!), double.parse(_userAddress!.long!));
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
        child: GoogleMap(
          layoutDirection:
              AppLocalizations.of(context)!.locale!.languageCode == "ar"
                  ? TextDirection.rtl
                  : TextDirection.ltr,
          minMaxZoomPreference: MinMaxZoomPreference.unbounded,
          markers: <Marker>{
            Marker(
              onDragEnd: (latLng) {
                setState(() {
                  addressProvider.mapLatLng = latLng;
                });
              },
              draggable: true,
              markerId: const MarkerId("1"),
              position: addressProvider.mapLatLng,
              icon: addressProvider.myMarker!,
            )
          },
          initialCameraPosition: CameraPosition(
            target: addressProvider.mapLatLng,
            zoom: 17.5,
          ),
          mapType: MapType.normal,
          compassEnabled: true,
          onMapCreated: _onMapCreated,
          onCameraMove: (latLng) {
            _showBottomSheet = false;
            addressProvider.mapLatLng = latLng.target;
            setState(() {});
          },
          onTap: (latLng) {
            _showBottomSheet = false;
            addressProvider.mapLatLng = latLng;
            setState(() {});
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
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

  void _onMapCreated(GoogleMapController cntlr) {
    try {
      final addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      _controller = cntlr;
      _location!.onLocationChanged.listen((l) {
        if (!addressProvider.initMap) {
          addressProvider.mapLatLng = LatLng(l.latitude!, l.longitude!);
          addressProvider.initMap = true;
          setState(() {});
        }
        _controller!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: addressProvider.mapLatLng,
              zoom: 0,
            ),
          ),
        );
      });
    } catch (_) {}
  }
}
