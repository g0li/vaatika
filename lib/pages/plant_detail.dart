import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlantDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.brown),
          backgroundColor: Colors.white,
          title: Text(
            'Plant Name',
            style: TextStyle(fontSize: 16, color: Colors.brown),
          ),
        ),
        bottomNavigationBar: ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.resolveWith(
                  (states) => Size(MediaQuery.of(context).size.width, 48)),
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.green)),
          child: Text('Save'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
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
                    width: MediaQuery.of(context).size.width * .6,
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          hintText: 'Quantity', border: InputBorder.none),
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
