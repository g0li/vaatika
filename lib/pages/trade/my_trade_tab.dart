import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/widgets/home_plant_item.dart';
import 'package:vrksh_vaatika/widgets/my_plant_item.dart';

import 'new_trade.dart';

class MyTradeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (c, i) => MyPlantItem(),
            itemCount: 3,
          ),
        ],
      ),
    );
  }
}
