import 'package:flutter/material.dart';

import 'my_trade_tab.dart';
import 'open_trade_tab.dart';

class TradePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.brown),
          backgroundColor: Colors.white,
          title: Text(
            'Plant Trading',
            style: TextStyle(fontSize: 16, color: Colors.brown),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: TabBar(
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Open Trades",
                    style: TextStyle(fontSize: 16, color: Colors.brown),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "My Trades",
                    style: TextStyle(fontSize: 16, color: Colors.brown),
                  ),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            OpenTradeTab(),
            MyTradeTab(),
          ],
        ),
      ),
    );
  }
}
