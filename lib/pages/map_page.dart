import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final LatLng location;

  const MapPage({Key key, this.location}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  String _mapStyle;
  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  bool isMapLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: markers.entries.length > 0
          ? ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.resolveWith(
                      (states) => Size(MediaQuery.of(context).size.width, 48)),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.green)),
              child: Text('Save Location'),
              onPressed: () {
                Navigator.pop(context, markers.entries.first.value.position);
              },
            )
          : null,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
            top: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                markers: Set<Marker>.of(markers.values),
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                myLocationEnabled: true,
                onLongPress: (_) {
                  _addMarkerLongPressed(_);
                },
                initialCameraPosition: CameraPosition(
                    target: widget.location, bearing: 0, zoom: 14),
                onMapCreated: (GoogleMapController controller) async {
                  isMapLoading = false;
                  _controller.complete(controller);
                  _controller.future
                      .then((value) => value.setMapStyle(_mapStyle));
                },
                padding: EdgeInsets.only(bottom: 220, right: 8, top: 84),
              ),
            )),
      ),
    );
  }

  Future _addMarkerLongPressed(LatLng latlang) async {
    setState(() {
      final MarkerId markerId = MarkerId("RANDOM_ID");
      Marker marker = Marker(
        markerId: markerId,
        draggable: true,
        position:
            latlang, //With this parameter you automatically obtain latitude and longitude
        infoWindow: InfoWindow(
          title: "Marker here",
          snippet: 'This looks good',
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      markers[markerId] = marker;
    });

    //This is optional, it will zoom when the marker has been created
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(latlang, 17.0));
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
}
