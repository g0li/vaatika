import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vrksh_vaatika/services/my_listings_provider.dart';
import 'package:vrksh_vaatika/widgets/home_plant_item.dart';
import 'package:vrksh_vaatika/widgets/my_plant_item.dart';

import 'new_trade.dart';

class MyTradeTab extends StatelessWidget {
  MyListingsProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyListingsProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green),
                      minimumSize: MaterialStateProperty.resolveWith((states) =>
                          Size(MediaQuery.of(context).size.width, 48)))),
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => NewTradeItemPage()));
                  },
                  icon: Icon(Icons.park),
                  label: Text('New Listing')),
            ),
          ),
          provider.listings != null
              ? Visibility(
                  visible: provider.listings != null,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (c, i) => MyPlantItem(
                      isOffer: false,
                      data: provider.listings.data[i],
                      onDelete: () {
                        provider.deleteListing(
                            context, provider.listings.data[i].id);
                      },
                    ),
                    itemCount: provider.listings.data.length,
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Center(
                        child: CircularProgressIndicator(),
                      )),
                )
        ],
      ),
    );
  }
}
