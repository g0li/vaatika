import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/model/garden.dart';
import 'package:vrksh_vaatika/pages/plant_detail.dart';
import 'package:vrksh_vaatika/provider/plant_detail_provider.dart';
import 'package:vrksh_vaatika/services/garden_services.dart';

class GardenPage extends StatefulWidget {
  @override
  _GardenPageState createState() => _GardenPageState();
}

class _GardenPageState extends State<GardenPage> {
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
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (c) => ChangeNotifierProvider(
                    child: PlantDetailPage(),
                    create: (c) => PlantDetailProvider(c, null),
                  ),
                )).then((value) => setState(() {}));
          });
        },
      ),
      body: FutureBuilder<Garden>(
        future: GardenService.getGarden(context),
        builder: (context, snap) {
          if (snap.hasError) return Text('snap error');
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return LinearProgressIndicator();
              break;
            default:
              Garden garden = snap.data;
              if (garden.data.length > 0)
                return GridView.builder(
                  itemCount: garden.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 4),
                  itemBuilder: (context, i) {
                    Datum datum = garden.data[i];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (c) => ChangeNotifierProvider(
                                child: PlantDetailPage(),
                                create: (c) => PlantDetailProvider(c, datum),
                              ),
                            )).then((value) => setState(() {}));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Flexible(
                              child: Image.memory(
                                base64Decode(datum.image),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                              fit: FlexFit.tight,
                              flex: 3,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Flexible(
                              child: Text(datum.plantName),
                              fit: FlexFit.tight,
                              flex: 1,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              else
                return Container(
                  child: Center(
                    child:
                        Text('Your garden seems empty, add more green to it.'),
                  ),
                );
          }
        },
      ),
    );
  }
}
