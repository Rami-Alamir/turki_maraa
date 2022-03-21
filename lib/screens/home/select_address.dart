import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:new_turki/models/user_address.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/rectangle_text_field.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    if (widget.addressIndex != -100) {
      final _addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      _userAddress = _addressProvider.userAddress!.data![widget.addressIndex];
      _addressProvider.mapLatLng = LatLng(
          double.parse(_userAddress!.lat!), double.parse(_userAddress!.long!));
      _addressProvider.descriptionController.text = _userAddress!.comment!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _addressProvider = Provider.of<AddressProvider>(context);
    final _auth = Provider.of<Auth>(context);

    return Scaffold(
      extendBody: true,
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr("choose_delivery_location"),
      ),
      body: Stack(
        children: [
          Container(
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
                zoom: widget.addressIndex == -100 ? 5 : 17.5,
              ),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              onCameraMove: (latLng) {
                _addressProvider.mapLatLng = latLng.target;
                //  _addressProvider.printA(latLng.target);

                setState(() {});
              },
              onTap: (latLng) {
                _addressProvider.mapLatLng = latLng;
                setState(() {});
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RectangleTextField(
                  white: true,
                  customWidth: SizeConfig.screenWidth! * 0.9,
                  hint: AppLocalizations.of(context)!.tr('description'),
                  controller: _addressProvider.descriptionController,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                ),
                RoundedRectangleButton(
                  title: AppLocalizations.of(context)!.tr('confirm_location'),
                  fontSize: 16.0,
                  width: SizeConfig.screenWidth! * 0.9,
                  padding: const EdgeInsets.all(10),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (widget.addressIndex == -100)
                      await _addressProvider.addNewAddress(
                          context, _auth.isAuth ? _auth.accessToken : "");
                    else
                      await _addressProvider.updateAddress(
                          context,
                          _auth.isAuth ? _auth.accessToken : "",
                          _userAddress?.id ?? 0);
                  },
                ),
              ],
            ),
          )
        ],
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
