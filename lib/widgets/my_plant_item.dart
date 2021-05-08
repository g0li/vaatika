import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/pages/trade/edit_trade.dart';
import 'package:vrksh_vaatika/pages/trade/new_trade.dart';
import 'package:vrksh_vaatika/provider/edit_listing_provider.dart';
import 'package:vrksh_vaatika/services/listings_services.dart';

class MyPlantItem extends StatefulWidget {
  MyPlantItem({this.data, this.onDelete, @required this.isOffer});
  final Datum data;
  final Function onDelete;
  final bool isOffer;
  @override
  _MyPlantItemState createState() => _MyPlantItemState();
}

class _MyPlantItemState extends State<MyPlantItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          IntrinsicHeight(
              child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (widget.data.image != null)
                Flexible(
                  child: Image.memory(
                    base64Decode(widget.data.image),
                    height: 100,
                    fit: BoxFit.fill,
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
                      Text(widget.data.plantName),
                      Text('Trading for : ${widget.data.lookingFor}'),
                      Text('Status : ACTIVE'),
                    ],
                  ),
                ),
                flex: 3,
                fit: FlexFit.tight,
              )
            ],
          )),
          widget.isOffer == true
              ? Row(
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
                                      create: (c) =>
                                          EditListingProvider(c, widget.data),
                                    )));
                      },
                    )),
                    Expanded(
                        child: TextButton(
                      child: Text('Delete',
                          style: TextStyle(
                            color: Colors.red.shade900,
                          )),
                      onPressed: () {
                        widget.onDelete();
                      },
                    ))
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
