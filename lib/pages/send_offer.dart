import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/services/listings_services.dart';
import 'package:vrksh_vaatika/services/my_listings_provider.dart';
import 'package:vrksh_vaatika/services/trade_services.dart';

class SendOfferPage extends StatefulWidget {
  final Datum listingData;

  SendOfferPage({@required this.listingData});

  @override
  _SendOfferPageState createState() => _SendOfferPageState();
}

class _SendOfferPageState extends State<SendOfferPage> {
  Datum selectedLising;
  Listings offeredListing;
  bool showLoader;
  bool hasConfirmedOffer = false;

  setLoader(bool val) {
    setState(() {
      showLoader = val;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        setLoader(true);
        var offer = await ListingsService.getSingleListing(
          context,
          widget.listingData.id,
        );
        if (offer != null) {
          setState(() {
            offeredListing = offer;
          });
        }
        setLoader(false);
      } catch (err) {
        setLoader(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.brown),
        backgroundColor: Colors.white,
        title: Text(
          offeredListing != null
              ? 'Trade offer with ${offeredListing.data[0].userName}'
              : '',
          style: TextStyle(fontSize: 16, color: Colors.brown),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(offeredListing != null
                    ? 'This trade : You are trading with ${offeredListing.data[0].userName ?? ''}'
                    : ''),
                // subtitle:
                //     Text('username has been on Vaatika since 8 November, 2020'),
              ),
              if (showLoader) LinearProgressIndicator(),
            ],
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
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: (selectedLising != null &&
                                selectedLising.plantsList.length > 0)
                            ? selectedLising.plantsList.length + 1
                            : 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 4),
                        itemBuilder: (context, i) {
                          if ((selectedLising != null &&
                                  i == selectedLising.plantsList.length) ||
                              (selectedLising == null)) {
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
                                  _selectListingToOffer(
                                    context,
                                  );
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
                                        image: selectedLising
                                                    .plantsList[i].image ==
                                                null
                                            ? null
                                            : DecorationImage(
                                                image: MemoryImage(
                                                  base64Decode(
                                                    selectedLising
                                                        .plantsList[i].image,
                                                  ),
                                                ),
                                                fit: BoxFit.fill,
                                              ),
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
                                    child: Text(
                                        '${selectedLising.plantsList[i].plantName ?? ''}'),
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
                      value: hasConfirmedOffer,
                      onChanged: (bool val) {
                        setState(() {
                          hasConfirmedOffer = val;
                        });
                      },
                      title: Text('Click here to confirm trade contents.'),
                    ),
                  ),
                  if (offeredListing != null)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                              '${offeredListing.data[0].userName}\'s plants:'),
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
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  offeredListing.data[0].plantsList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
                                            image: offeredListing.data[0]
                                                        .plantsList[i].image ==
                                                    null
                                                ? null
                                                : DecorationImage(
                                                    image: MemoryImage(
                                                      base64Decode(
                                                        offeredListing
                                                            .data[0]
                                                            .plantsList[i]
                                                            .image,
                                                      ),
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
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
                                        child: Text(
                                            '${offeredListing.data[0].plantsList[i].plantName}'),
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
                          child: Text(offeredListing == null
                              ? ''
                              : '${offeredListing.data[0].userName} will be notified of this trade offer through Vaatika'),
                        ),
                      ],
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
                      onPressed: (showLoader ||
                              selectedLising == null ||
                              offeredListing == null)
                          ? null
                          : () {
                              print('Lising id: ${offeredListing.data[0].id}');
                              print('Offered listing id: ${selectedLising.id}');
                              _createOffer(
                                offeredListing.data[0].id,
                                selectedLising.id,
                              );
                            },
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
                      onPressed: showLoader
                          ? null
                          : () {
                              Navigator.of(context).pop();
                            },
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

  _selectListingToOffer(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        builder: (BuildContext ctx) {
          var listingProvider = Provider.of<MyListingsProvider>(ctx);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
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
                if (listingProvider.listingLoader)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                (listingProvider.listings != null &&
                        listingProvider.listings.data != null &&
                        listingProvider.listings.data.length > 0)
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: listingProvider.listings.data.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (ctx, i) {
                            return GestureDetector(
                              onTap: () {
                                _onSelectListing(
                                  listingProvider.listings.data[i],
                                );
                                Navigator.of(ctx).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Card(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Looking for: ${listingProvider.listings.data[i].lookingFor}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        height: 100,
                                        width: double.maxFinite,
                                        child: ListView.builder(
                                          itemCount: listingProvider.listings
                                              .data[i].plantsList.length,
                                          shrinkWrap: true,
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (ctx, j) {
                                            var plantsList = listingProvider
                                                .listings.data[i].plantsList;

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16),
                                              child: Card(
                                                elevation: 0,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 16,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      if (plantsList[i].image !=
                                                          null)
                                                        Image.memory(
                                                          base64Decode(
                                                            plantsList[j].image,
                                                          ),
                                                          height: 40,
                                                          width: 40,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            plantsList[j]
                                                                    .plantName ??
                                                                '',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            'Qty: ${plantsList[j].quantity ?? 'NA'}',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            plantsList[j]
                                                                    .category ??
                                                                '',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                              ),
                            );
                          },
                        ),
                      )
                    : listingProvider.listingLoader
                        ? Container()
                        : Center(
                            child: Text(
                              'You have no listings, create one first!',
                            ),
                          )
              ],
            ),
          );
        });
  }

  _onSelectListing(Datum listing) {
    setState(() {
      selectedLising = listing;
    });
  }

  _createOffer(int listingId, int offeredListingId) async {
    try {
      if (!hasConfirmedOffer) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please confirm your offer'),
        ));
        return;
      }

      setLoader(true);

      var res = await TradeServices.createTradeOffer(
        mContext: context,
        listingId: listingId,
        offeredListingId: offeredListingId,
      );

      setLoader(false);

      if (res.status == 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res.message)));
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res.message ?? 'Some error occured'),
        ));
      }
    } catch (err) {
      print(err.toString());
      setLoader(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err['message'] ?? 'Some error occured'),
      ));
    }
  }
}
