import 'package:flutter/material.dart';

class OfferItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('username has offered you a trade: '),
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
                Text('username offered: '),
                GridView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: 2,
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
                Text('For your: '),
                GridView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: 2,
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Offer expires on 7 Dec',
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
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
