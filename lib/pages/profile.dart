import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.edit), onPressed: () {})],
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.brown),
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 16, color: Colors.brown),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black
                    // image: DecorationImage(
                    //   image: AssetImage('assets/profile.png'),
                    //   fit: BoxFit.cover,
                    // ),
                    ),
            width: 100,
            height: 100,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: 'Name', border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        hintText: 'Phone no.', border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: AbsorbPointer(
                    absorbing: true,
                    child: GoogleMap(
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      myLocationEnabled: false,
                      initialCameraPosition:
                          CameraPosition(target: LatLng(19, 20), zoom: 8),
                      onMapCreated: (GoogleMapController controller) async {
                        // _controller.complete(controller);
                        // controller.setMapStyle(_mapStyle);
                      },
                      padding: EdgeInsets.only(bottom: 220, right: 8, top: 84),
                      mapType: MapType.terrain,
                    ),
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Sign out',
                    style: TextStyle(color: Colors.green),
                  )),
              alignment: Alignment.centerLeft,
            ),
          )
        ],
      ),
    );
  }
}
