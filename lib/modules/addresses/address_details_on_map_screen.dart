import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:safri/modules/addresses/widgets/get_location_service.dart';
import 'package:safri/shared/images/images.dart';

import '../../shared/constants.dart';
import '../../shared/styles/colors.dart';
import '../../widgets/item_shared/Text_form.dart';
import '../../widgets/item_shared/default_button.dart';
import 'cubit/address_cubit/address_cubit.dart';
import 'data/request/update_address_request.dart';

class AddressDetailsOnMapScreen extends StatefulWidget {
    final UpdateAddressRequest? updateAddressRequest;
    const AddressDetailsOnMapScreen({Key? key, this.updateAddressRequest,  }) : super(key: key);


  @override
  State<AddressDetailsOnMapScreen> createState() => AddAddressScreenState();
}

class AddAddressScreenState extends State<AddressDetailsOnMapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late final GoogleMapController controller;

  String location = 'nolocationinformation'.tr();

  String googleApikey = "AIzaSyBZD6gk02Nv1rwUyxplxahW690rtRm1mu0";
  double currentZoom = 14.0;
  LatLng? initLatLng;

  @override
  void initState() {
    if(widget.updateAddressRequest?.latitude !=null){
      print("asaskaskjaskkdklkdsklds");

      initLatLng=LatLng(double.tryParse(widget.updateAddressRequest!.latitude.toString())??0, double.tryParse(widget.updateAddressRequest!.longitude.toString())??0);

    }
    else{
    print("initLatLng = null");
    initLatLng = null;
    _currentLocation = null;
    setState(() {});
      }

    if (initLatLng != null) _currentLocation = CameraPosition(target: initLatLng!, zoom: 14.4746);
    bool goToMyLocation = _currentLocation == null;
    //29.374625662387505, 47.97818036461731
    _currentLocation ??= const CameraPosition(target: LatLng(29.374625662387505, 47.97818036461731), zoom: 14.4746);
    _controller.future.then((value) {
      controller = value;
      onTapMap(_currentLocation!.target);
      if (goToMyLocation) _moveToMyLocation();
    });

    super.initState();
  }

  static CameraPosition? _currentLocation;
  final List<Marker> _markers = [];

  var formKey = GlobalKey<FormState>();
  var addressDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Stack(
        children: [
          GoogleMap(
            onTap: onTapMap,
            markers: _markers.toSet(),
            zoomGesturesEnabled: true,
            //enable Zoom in, out on map
            zoomControlsEnabled: false,
            mapType: MapType.normal,

            initialCameraPosition: _currentLocation!,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraIdle: () async {
              //when map drag stops
              List<Placemark> placemarks = await placemarkFromCoordinates(_currentLocation!.target.latitude, _currentLocation!.target.longitude);
              //get place name from lat and lang
              Placemark p = placemarks[placemarks.length > 1 ? 1 : 0];
              location = [p.administrativeArea, p.locality, p.street].where((e) => e != null && e.isNotEmpty).join(', ');
              // location = "${placemarks[1].administrativeArea}, ${placemarks[1].locality}, ${placemarks[1].street}";
              setState(() {});
            },
          ),
          Positioned(
            //search input bar
            child: SafeArea(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildAppBar(),
                ),
                const SizedBox(
                  height: 8,
                ),
                //todo if you want enable search delete comments
                InputTextFormField(
                    paddingHorizontal: 20,
                    paddingVertical: 0,
                    readOnly: true,
                    onTap: () async {
                      final place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleApikey,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [Component(Component.country, 'eg')],
                          //google_map_webservice package
                          onError: (err) {});

                      if (place != null) {
                        setState(() {
                          location = place.description.toString();
                        });
                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(
                          apiKey: googleApikey,
                          apiHeaders: await const GoogleApiHeaders().getHeaders(),
                          //from google_api_headers package
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        var newlatlang = LatLng(lat, lang);

                        //move map camera to selected place with animation
                        controller.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: newlatlang, zoom: currentZoom),
                          ),
                        );
                        // _markers.clear();
                        // id = id + 1;
                        // _markers.add(Marker(markerId: MarkerId('$id'), position: LatLng(lat, lang)));
                        // _setMarker(LatLng(currentPosition!.latitude, currentPosition!.longitude));
                        onTapMap(LatLng(lat, lang));
                      }
                    },
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        Images.location1,color:Color(0xffEF7F18),
                      ),
                    ),
                    fillColor: Colors.white,
                    hintText: tr("Address_Details"),
                    textEditingController: addressDetailsController,
                    validator: (val) {
                      if (val.isEmpty) {
                        return tr("Address_Details_can_not_be_empty");
                      }
                    },
                    textInputType: TextInputType.text,
                    inputAction: TextInputAction.done),
              ]),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: DefaultButton(
                    height: 50,
                    onTap: () {
                      debugPrint("_currentLocation!.target.latitude.toString()");
                      debugPrint(_currentLocation!.target.latitude.toString());
                      debugPrint(_currentLocation!.target.longitude.toString());

                       AddressCubit.get(context).addressDetailsController.text = location;
                       AddressCubit.get(context).lat = _currentLocation!.target.latitude.toString();
                        AddressCubit.get(context).lang = _currentLocation!.target.longitude.toString();
                      Navigator.pop(context);
                    },
                    text: tr('Done'),
                  ),
                ),

                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
      //todo if want enable locate me delete this comment
      //floatingActionButton: InkWell(onTap: _moveToMyLocation, child: myLocationIcon()),
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
          toolbarHeight: 70,
          titleSpacing: 2,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                   changeIconByLang(),
                  color: const Color(0xff000000),
                  size: 40,
                )),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(Images.appIcon),
            ),
          ]),
    );
  }

  Widget myLocationIcon() => Container(
        height: 40,
        width: 130,
        decoration: BoxDecoration(color: defaultColor, borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: _isMyLocationLoading
                ? const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const  AutoSizeText(
                "locate_me",
                minFontSize: 8,
                maxLines: 1,style: TextStyle(color: Colors.white, fontSize: 12))),
      );

  // _isMyLocationLoading ? const Center(child: CircularProgressIndicator(color: Colors.white)) : const Icon(Icons.gps_fixed_outlined);

  void onTapMap(LatLng latLng) async {
    print("latLnglatLng");
    print(latLng.latitude);
    print(latLng.longitude);

    ///from me
    //   26.15272883623953
    //    32.717676758766174

    ///from api
    // "latitude": "26.15272883623953",
    //    "longitude": "32.717676758766174",

    Marker marker = Marker(
      markerId: MarkerId(latLng.toString()),
      position: latLng,
    );
    _moveToLocation(latLng);
    if (_markers.isEmpty) _markers.add(marker);
    if (_markers.isNotEmpty) _markers[0] = marker;
    // location = place?.description.toString()??"nolocationinformation".tr();
    setState(() {});
  }

  void _setCurrentLocation(LatLng latLng) async {
    _currentLocation = CameraPosition(target: latLng, zoom: (await controller.getZoomLevel()));
  }

  bool _isMyLocationLoading = false;

  void _moveToMyLocation() async {
    _isMyLocationLoading = true;
    setState(() {});
    Position? locationData = await GetLocationServ.getLocation(forceUpdate: true);
    if (locationData != null) {
      LatLng target = LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0);
      onTapMap(target);
    }
    _isMyLocationLoading = false;
    setState(() {});
  }

  void _moveToLocation(LatLng target) {
    _setCurrentLocation(target);
    CameraPosition position = CameraPosition(target: target, zoom: 16.5);
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  void _onConfirm() {
    print("dsddsffsdff");
    print("lat");
    print(_currentLocation?.target.latitude);
    print("long");
    print(_currentLocation?.target.longitude);

    // if (widget.onConfirm != null) {
    //   widget.onConfirm!(_currentLocation?.target.latitude ?? 0, _currentLocation?.target.longitude ?? 0, location);
    // }
    // Navigator.of(context).pop();
  }
}
