import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart' as listings;
import 'package:vrksh_vaatika/model/trade_offers.dart';
import 'package:vrksh_vaatika/provider/profile_provider.dart';
import 'package:vrksh_vaatika/services/listings_services.dart';

class OfferItem extends StatelessWidget {
  final Datum offer;
  OfferItem({@required this.offer});

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context);
    var userId = profileProvider.appUser.id;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(userId == offer.offererId
                ? 'You offered ${offer.listerName} a trade:'
                : '${offer.offererName} has offered you a trade'),
            trailing: IconButton(
              icon: Icon(Icons.flag),
              onPressed: () {},
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userId == offer.listerId
                      ? '${offer.offererName} offered: '
                      : 'You offered',
                ),
                FutureBuilder<listings.Listings>(
                    future: ListingsService.getSingleListing(
                        context, offer.offeredListingId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Some error occured');
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          var listings = snapshot.data;

                          return (listings != null &&
                                  listings.data != null &&
                                  listings.data.length > 0)
                              ? GridView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: listings.data.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 4,
                                  ),
                                  itemBuilder: (context, i) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Flexible(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: MemoryImage(
                                                    base64.decode(
                                                      listings.data[i].image,
                                                    ),
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            10)),
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
                                                '${listings.data[i].plantName}'),
                                            fit: FlexFit.tight,
                                            flex: 1,
                                          )
                                        ],
                                      ),
                                    );
                                  })
                              : Container(child: Text('Some error occured'));
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          height: 2,
                          color: Colors.black.withOpacity(.2),
                        ),
                      ),
                      Flexible(
                        child: Transform.rotate(
                            child: Icon(
                              Icons.compare_arrows_rounded,
                              size: 32,
                            ),
                            angle: 1.5708),
                        flex: 1,
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          height: 2,
                          color: Colors.black.withOpacity(.2),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  userId == offer.listerId
                      ? 'For your'
                      : 'For ${offer.listerName}\'s',
                ),
                FutureBuilder<listings.Listings>(
                    future: ListingsService.getSingleListing(
                      context,
                      offer.listingId,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Some error occured');
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          var listings = snapshot.data;

                          return (listings != null &&
                                  listings.data != null &&
                                  listings.data.length > 0)
                              ? GridView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: listings.data.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 4,
                                  ),
                                  itemBuilder: (context, i) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Flexible(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: MemoryImage(
                                                    base64.decode(
                                                      listings.data[i].image,
                                                    ),
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            10)),
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
                                                '${listings.data[i].plantName}'),
                                            fit: FlexFit.tight,
                                            flex: 1,
                                          )
                                        ],
                                      ),
                                    );
                                  })
                              : Container(child: Text('Some error occured'));
                      }
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   'Offer expires on 7 Dec',
                  //   style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  // ),
                  Row(children: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Respond to Offer',
                          style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Decline Trade',
                          style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ]),
                ]),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
