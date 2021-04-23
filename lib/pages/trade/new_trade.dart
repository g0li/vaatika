import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vrksh_vaatika/pages/garden.dart';

class NewTradeItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.brown),
        backgroundColor: Colors.white,
        title: Text(
          'New Listing',
          style: TextStyle(fontSize: 16, color: Colors.brown),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.resolveWith(
                (states) => Size(MediaQuery.of(context).size.width, 48)),
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => Colors.green)),
        child: Text('Create Listing'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
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
                        minimumSize: MaterialStateProperty.resolveWith(
                            (states) =>
                                Size(MediaQuery.of(context).size.width, 48)))),
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => GardenPage()));
                    },
                    icon: Icon(Icons.grass),
                    label: Text('Select From Garden')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                      color: Colors.grey.shade100,
                    ),
                  ),
                  Flexible(
                    child: Text(' or '),
                    flex: 1,
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(3.0),
                      height: 2,
                      color: Colors.grey.shade100,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    color: Colors.green,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Plant Name', border: InputBorder.none),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Description  ', border: InputBorder.none),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .5,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              hintText: 'Owned Since (MM/YY)',
                              border: InputBorder.none),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .3,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              hintText: 'Quantity', border: InputBorder.none),
                        ),
                      ),
                    ],
                  )
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
