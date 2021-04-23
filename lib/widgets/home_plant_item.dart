import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/pages/offer_details.dart';
import 'package:vrksh_vaatika/pages/send_offer.dart';

class HomePlantItem extends StatelessWidget {
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
                      Text('Plant Name'),
                      Text('0.2 km'),
                      Wrap(
                        children: [
                          Text('Trading for : '),
                          Text('PLANT '),
                          Text('PLANT '),
                          Text('PLANT '),
                          Text('PLANT '),
                          Text('PLANT '),
                        ],
                      ),
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
                child: Text('Details',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (c) => OfferDetailsPage()));
                },
              )),
              Expanded(
                  child: TextButton(
                child: Text('Make An Offer',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (c) => SendOfferPage()));
                },
              )),
              Expanded(
                  child: TextButton(
                child: Text('Chat',
                    style: TextStyle(
                      color: Colors.black,
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
