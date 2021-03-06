import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vrksh_vaatika/pages/login.dart';
import 'package:vrksh_vaatika/pages/profile.dart';
import 'package:vrksh_vaatika/pages/trade/trade.dart';
import 'package:vrksh_vaatika/provider/homeprovider.dart';
import 'package:vrksh_vaatika/provider/profile_provider.dart';
import 'package:vrksh_vaatika/widgets/expandable_fab.dart';
import 'package:vrksh_vaatika/widgets/home_plant_item.dart';

import 'garden.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  HomeProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      floatingActionButton: provider.currentLocation == null
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: FloatingActionButton(
                elevation: 0,
                onPressed: null,
              ))
          : ExpandableFab(
              distance: 112.0,
              children: [
                ActionButton(
                  onPressed: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(context,
                              CupertinoPageRoute(builder: (c) => GardenPage()))
                          .then((value) => HomeProvider(context));
                    });
                  },
                  icon: Icon(Icons.grass),
                ),
                ActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (c) => ChangeNotifierProvider(
                                  child: ProfilePage(),
                                  create: (c) => ProfileProvider(c),
                                )));
                  },
                  icon: const Icon(Icons.face_retouching_natural),
                ),
                ActionButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (c) => TradePage()));
                  },
                  icon: const Icon(Icons.swap_calls),
                ),
              ],
            ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          top: true,
          child: Stack(
            children: [
              provider.currentLocation == null
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey[800],
                          highlightColor: Colors.grey[100],
                          child: Center(
                            child: CircularProgressIndicator(),
                          )),
                    )
                  : GoogleMap(
                      markers: provider.markers,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: true,
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      myLocationEnabled: true,
                      initialCameraPosition: provider.currentLocation,
                      onMapCreated: (GoogleMapController controller) async {
                        isMapLoading = false;
                        _controller.complete(controller);
                        _controller.future
                            .then((value) => value.setMapStyle(_mapStyle));
                      },
                      padding: EdgeInsets.only(bottom: 220, right: 8, top: 84),
                    ),
              // headerSearchBarView(),
              Visibility(
                visible: provider.listing != null &&
                    provider.listing.data.length > 0,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .25,
                      child: provider.listing != null
                          ? PageView.builder(
                              controller: provider.controller,
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.listing.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return HomePlantItem(
                                    provider.listing.data[index]);
                              },
                            )
                          : Container(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerSearchBarView() {
    return Column(
      children: [
        PhysicalModel(
          color: Colors.transparent,
          elevation: 3,
          shadowColor: Colors.black,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white,
                border: Border.all(color: Colors.transparent)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 15),
                Icon(Icons.search),
                SizedBox(width: 10),
                Expanded(
                    child: Container(
                  child: TextFormField(
                      // focusNode: serchFN,
                      maxLines: 1,
                      // style: FONT_CONST.REGULAR_TEXT_BLACKTEXT_14,
                      // controller: _searchController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {},
                      onChanged: (_) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Search area',
                      )),
                )),
                SizedBox(width: 10),
                Material(
                  type: MaterialType.transparency,
                  shape: CircleBorder(),
                  child: IconButton(
                      splashRadius: 23,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          showFilter = !showFilter; //manage state
                          // if (showFilter == true) showSearchResult = false;
                        });
                      },
                      icon: Icon(Icons.filter_alt)),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
        Visibility(
          child: filters(),
          visible: showFilter,
        ),
      ],
    );
  }

  bool showFilter = false;
  Widget filters() {
    return Container(
      color: Colors.black12,
      child: Column(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: filter
                  .map(
                    (e) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 1,
                        color: Colors.grey.shade50,
                      ))),
                      child: Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.grey.shade500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e['title'],
                                    // style: FONT_CONST.MEDIUM_TEXT_BLACKTEXT_12,
                                  ),
                                  Text(
                                    e['desc'],
                                    // style: FONT_CONST.REGULAR_TEXT_BLACKTEXT_12,
                                  ),
                                ],
                              ),
                            ),
                            Checkbox(
                              onChanged: (_) {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  e['isactive'] = _;
                                });
                              },
                              value: e['isactive'],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  showFilter = !showFilter;
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
              child: Text('Apply & Search'),
            ),
          )
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> filter = [
  {
    'title': 'Filter Title ',
    'desc': 'brief filter description',
    'isactive': false
  },
  {
    'title': 'Filter Title ',
    'desc': 'brief filter description',
    'isactive': false
  },
  {
    'title': 'Filter Title ',
    'desc': 'brief filter description',
    'isactive': false
  },
  {
    'title': 'Filter Title ',
    'desc': 'brief filter description',
    'isactive': false
  },
  {
    'title': 'Filter Title ',
    'desc': 'brief filter description',
    'isactive': false
  },
];
