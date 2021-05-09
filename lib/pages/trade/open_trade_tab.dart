import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/services/open_listings_provider.dart';
import 'package:vrksh_vaatika/widgets/home_plant_item.dart';
import 'package:vrksh_vaatika/widgets/open_trade_item.dart';

class OpenTradeTab extends StatelessWidget {
  OpenListingsProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<OpenListingsProvider>(context);
    return ListView.builder(
      itemBuilder: (c, i) => OpenTradePlantItem(provider.tradeOffers.data[i]),
      itemCount:
          provider.tradeOffers != null && provider.tradeOffers.data != null
              ? provider.tradeOffers.data.length
              : 0,
    );
  }
}
