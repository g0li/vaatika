import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/widgets/my_plant_item.dart';
import 'dart:math' as math;

import 'package:vrksh_vaatika/widgets/offer_items.dart';

class OfferDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown.shade50,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.brown),
          backgroundColor: Colors.white,
          title: Text(
            'Trade Offers',
            style: TextStyle(fontSize: 16, color: Colors.brown),
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight * 2.5),
              child: MyPlantItem()),
        ),
        body: ListView.builder(
          itemBuilder: (c, i) => OfferItem(),
          itemCount: 10,
        ));
  }
}
