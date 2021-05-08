import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/services/listings_services.dart';

class HomeProvider extends ChangeNotifier {
  CameraPosition currentLocation;
  Listings listing;
  Set<Marker> markers = {};
  HomeProvider(mContext) {
    _determinePosition().then((position) {
      currentLocation = CameraPosition(
          bearing: 0,
          target: LatLng(position.latitude, position.longitude),
          zoom: 14);
      ListingsService.getListings(mContext).then((listing) {
        this.listing = listing;
        if (listing != null && listing.data.length > 0) {
          getMarkerImage(listing);
          notifyListeners();
        } else {
          notifyListeners();
        }
      });
    });
  }

  PageController controller = PageController();
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

  getMarkerImage(Listings listng) async {
    markers.clear();
    print('listing length: ${listng.data.length}');
    for (int i = 0; i <= listng.data.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(listng.data[i].id.toString()),
          position: LatLng(listng.data[i].lat, listng.data[i].lng),
          onTap: () {
            controller.animateToPage(i,
                duration: Duration(milliseconds: 900), curve: Curves.elasticIn);
          }));
    }
  }

  Datum selectedMarker;
}
