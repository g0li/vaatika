import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/widgets/home_plant_item.dart';

class OpenTradeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (c, i) => HomePlantItem(),
      itemCount: 10,
    );
  }
}
