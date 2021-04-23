import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/pages/trade/new_trade.dart';

class MyPlantItem extends StatelessWidget {
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
                child: Text('Edit',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => NewTradeItemPage()));
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
