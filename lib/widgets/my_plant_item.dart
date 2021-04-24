import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/pages/trade/edit_trade.dart';
import 'package:vrksh_vaatika/pages/trade/new_trade.dart';
import 'package:vrksh_vaatika/provider/edit_listing_provider.dart';

class MyPlantItem extends StatelessWidget {
  MyPlantItem({this.data});
  Datum data;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          IntrinsicHeight(
              child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Container(
                  color: Colors.green.shade900,
                ),
                flex: 1,
                fit: FlexFit.tight,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.plantName),
                      Text('Trading for : ${data.lookingFor}'),
                      Text('Status : ACTIVE'),
                    ],
                  ),
                ),
                flex: 3,
                fit: FlexFit.tight,
              )
            ],
          )),
          Row(
            children: [
              Expanded(
                  child: TextButton(
                child: Text('Edit',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                                child: EditTradeItemPage(),
                                create: (c) => EditListingProvider(c, data),
                              )));
                },
              )),
              Expanded(
                  child: TextButton(
                child: Text('Delete',
                    style: TextStyle(
                      color: Colors.red.shade900,
                    )),
                onPressed: () {},
              ))
            ],
          )
        ],
      ),
    );
  }
}
