import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vrksh_vaatika/pages/plant_detail.dart';

class GardenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.brown),
        backgroundColor: Colors.white,
        title: Text(
          'My Garden',
          style: TextStyle(fontSize: 16, color: Colors.brown),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (c) => PlantDetailPage()));
        },
      ),
      body: GridView.builder(
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 4),
        itemBuilder: (context, i) => InkWell(
          onTap: () {
            Navigator.push(
                context, CupertinoPageRoute(builder: (c) => PlantDetailPage()));
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                  ),
                  fit: FlexFit.tight,
                  flex: 3,
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: Text('Plant Name'),
                  fit: FlexFit.tight,
                  flex: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
