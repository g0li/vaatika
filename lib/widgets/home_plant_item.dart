import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/pages/offer_details.dart';
import 'package:vrksh_vaatika/pages/send_offer.dart';
import 'package:vrksh_vaatika/provider/trade_provider.dart';

class HomePlantItem extends StatelessWidget {
  HomePlantItem(this.data);
  final Datum data;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * .9,
      child: Column(
        children: [
          Expanded(
            flex: 20,
            child: IntrinsicHeight(
                child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    child: Image.memory(
                      base64Decode(data.image),
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                  flex: 1,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.plantName),
                        // Text('0.2 km'),
                        Text('Trading for : ${data.lookingFor}'),
                        Text('Status : ${data.status}'),
                      ],
                    ),
                  ),
                  flex: 3,
                )
              ],
            )),
          ),
          Expanded(
            flex: 12,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    flex: 1,
                    child: TextButton(
                      child: Text('Details',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (c) => ChangeNotifierProvider(
                                      child: OfferDetailsPage(data: data),
                                      create: (c) => TradeProvider(
                                        c,
                                      ),
                                    )));
                      },
                    )),
                Expanded(
                    flex: 1,
                    child: TextButton(
                      child: Text('Make An Offer',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (c) => SendOfferPage()));
                      },
                    )),
                Expanded(
                    flex: 1,
                    child: TextButton(
                      child: Text('Chat',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      onPressed: () {},
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
