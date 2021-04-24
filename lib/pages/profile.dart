import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/model/user_body.dart';
import 'package:vrksh_vaatika/provider/profile_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileProvider provider;

  FocusNode nameFN = FocusNode(debugLabel: 'name');

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                provider.editProfile();
                // FocusScope.of(context)
                //     .requestFocus(provider.edit ? nameFN : FocusNode());
              })
        ],
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.brown),
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 16, color: Colors.brown),
        ),
      ),
      bottomNavigationBar: provider.edit
          ? ElevatedButton(
              onPressed: () async {
                UserBody body = UserBody(
                    contact: provider.phoneController.text.trim(),
                    deviceId: provider.appUser.deviceId,
                    id: provider.appUser.id,
                    lat: provider.appUser.lat,
                    lng: provider.appUser.lng,
                    name: provider.nameController.text.trim(),
                    os: provider.appUser.os,
                    profilePicture: pickedFile != null
                        ? base64Encode(await pickedFile.readAsBytes())
                        : provider.appUser.profilePicture);
                provider.updateProfile(context, body);
              },
              child: Text('Save'))
          : null,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            InkWell(
              onTap: () {
                if (provider.edit == true) setImage(context);
              },
              child: Container(
                margin: EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: pickedFile != null
                        ? FileImage(File(pickedFile.path))
                        : provider.appUser != null
                            ? MemoryImage(
                                base64Decode(provider.appUser.profilePicture))
                            : NetworkImage('https://via.placeholder.com/150'),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 100,
                height: 100,
              ),
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
                      focusNode: nameFN,
                      enabled: provider.edit,
                      controller: provider.nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: 'Name', border: InputBorder.none),
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
                      controller: provider.phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          labelText: 'Phone no.', border: InputBorder.none),
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
                        initialCameraPosition: provider.userLocation ??
                            CameraPosition(target: LatLng(19, 20), zoom: 8),
                        onMapCreated: (GoogleMapController controller) async {
                          // _controller.complete(controller);
                          // controller.setMapStyle(_mapStyle);
                        },
                        padding:
                            EdgeInsets.only(bottom: 220, right: 8, top: 84),
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
      ),
    );
  }

  PickedFile pickedFile;

  setImage(context) {
    showDialog(
        context: context,
        builder: (c) => AlertDialog(
              title: Text('Select Image'),
              content: Text('Please select an option'),
              actions: [
                TextButton(
                  onPressed: () {
                    ImagePicker()
                        .getImage(source: ImageSource.gallery)
                        .then((value) {
                      setState(() {
                        pickedFile = value;
                        Navigator.pop(context);
                      });
                    });
                  },
                  child: Text('Gallery'),
                ),
                TextButton(
                  onPressed: () {
                    ImagePicker()
                        .getImage(source: ImageSource.camera)
                        .then((value) {
                      setState(() {
                        pickedFile = value;
                        Navigator.pop(context);
                      });
                    });
                  },
                  child: Text('Camera'),
                ),
              ],
            ),
        useRootNavigator: true,
        barrierDismissible: false);
  }
}
