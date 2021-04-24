import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/services/listings_services.dart';

class HomeProvider extends ChangeNotifier {
  CameraPosition currentLocation;
  Listings listing;
  HomeProvider(mContext) {
    _determinePosition().then((position) {
      currentLocation = CameraPosition(
          bearing: 0,
          target: LatLng(position.latitude, position.longitude),
          zoom: 9.151926040649414);
      ListingsService.getListings(mContext).then((listing) {
        this.listing = listing;
        notifyListeners();
      });
    });
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
