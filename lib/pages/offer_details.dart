import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/provider/trade_provider.dart';
import 'package:vrksh_vaatika/widgets/my_plant_item.dart';
import 'dart:math' as math;

import 'package:vrksh_vaatika/widgets/offer_items.dart';

class OfferDetailsPage extends StatelessWidget {
  final Datum data;

  const OfferDetailsPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tradeProvider = Provider.of<TradeProvider>(context);
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
            child: MyPlantItem(
              isOffer: false,
              data: data,
            )),
      ),
      body: tradeProvider.tradeLoader
          ? LinearProgressIndicator()
          : (tradeProvider.tradeOfferlist != null &&
                  tradeProvider.tradeOfferlist.data != null &&
                  tradeProvider.tradeOfferlist.data.length > 0)
              ? ListView.builder(
                  itemBuilder: (c, i) =>
                      OfferItem(offer: tradeProvider.tradeOfferlist.data[i]),
                  itemCount: tradeProvider.tradeOfferlist.data.length,
                )
              : Container(),
    );
  }
}
