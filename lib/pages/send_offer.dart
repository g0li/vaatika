import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/pages/plant_detail.dart';

class SendOfferPage extends StatelessWidget {
  final Datum listingData;

  SendOfferPage({@required this.listingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.brown),
        backgroundColor: Colors.white,
        title: Text(
          'Trade offer with username',
          style: TextStyle(fontSize: 16, color: Colors.brown),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: ListTile(
            title: Text('This trade : You are trading with username'),
            subtitle:
                Text('username has been on Vaatika since 8 November, 2020'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Your plants:'),
                    subtitle:
                        Text('These are the plants you will lose in the trade'),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.shade100,
                    ),
                    padding: EdgeInsets.all(8),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 4),
                        itemBuilder: (context, i) {
                          if (i == 2) {
                            return Container(
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                color: Colors.green,
                                icon: Icon(Icons.add),
                                iconSize: 50,
                                onPressed: () {
                                  _selectListingToOffer(context);
                                },
                              ),
                            );
                          } else {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10)),
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
                            );
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      tileColor: Colors.green.shade50,
                      value: false,
                      onChanged: (_) {},
                      title: Text('Click here to confirm trade contents.'),
                    ),
                  ),
                  ListTile(
                    title: Text('username\'s plants:'),
                    subtitle: Text(
                        'These are the plants you will recieve in the trade'),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.shade100,
                    ),
                    padding: EdgeInsets.all(8),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 4),
                        itemBuilder: (context, i) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10)),
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
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'username will be notified of this trade offer through Vaatika'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButtonTheme(
                    data: ElevatedButtonThemeData(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.green),
                            minimumSize: MaterialStateProperty.resolveWith(
                                (states) => Size(
                                    MediaQuery.of(context).size.width, 48)))),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Make Offer'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButtonTheme(
                    data: TextButtonThemeData(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.green),
                            minimumSize: MaterialStateProperty.resolveWith(
                                (states) => Size(
                                    MediaQuery.of(context).size.width, 48)))),
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Cancel and Go Back'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // select a listing
  _selectListingToOffer(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        builder: (BuildContext ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Select a listing to offer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Looking for:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Show plants list here'),
                          ],
                        ),
                      )),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
