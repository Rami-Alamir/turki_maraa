import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/rectangle_text_field.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class AddNewAddress extends StatefulWidget {
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  GoogleMapController? _controller;
  Location? _location;

  @override
  Widget build(BuildContext context) {
    final _addressProvider = Provider.of<AddressProvider>(context);
    final _auth = Provider.of<Auth>(context);

    return Scaffold(
      extendBody: true,
      appBar: PrimaryAppBar(),
      body: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: GoogleMap(
              minMaxZoomPreference: MinMaxZoomPreference.unbounded,
              markers: Set<Marker>.of(
                <Marker>[
                  Marker(
                    onDragEnd: (latLng) {
                      setState(() {
                        _addressProvider.latLng = latLng;
                      });
                    },
                    draggable: true,
                    markerId: MarkerId("1"),
                    position: _addressProvider.latLng,
                    icon: _addressProvider.myMarker,
                    infoWindow: const InfoWindow(
                      title: '',
                    ),
                  )
                ],
              ),
              initialCameraPosition: CameraPosition(
                target: _addressProvider.latLng,
                zoom: 14,
              ),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              onCameraMove: (latLng) {
                _addressProvider.latLng = latLng.target;
                setState(() {});
              },
              onTap: (latLng) {
                _addressProvider.latLng = latLng;
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
                  title: AppLocalizations.of(context)!.tr('add_address'),
                  fontSize: 16.0,
                  width: SizeConfig.screenWidth! * 0.9,
                  padding: const EdgeInsets.all(10),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await _addressProvider.addNewAddress(
                        context, _auth.isAuth ? _auth.accessToken : "");
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
          _addressProvider.latLng = LatLng(l.latitude!, l.longitude!);
          _addressProvider.initMap = true;
          setState(() {});
        }
        _controller!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _addressProvider.latLng,
              zoom: 15,
            ),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
