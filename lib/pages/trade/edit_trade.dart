import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/model/category.dart';
import 'package:vrksh_vaatika/model/garden.dart';
import 'package:vrksh_vaatika/provider/edit_listing_provider.dart';
import 'package:vrksh_vaatika/services/listings_services.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart' as l;
import 'package:vrksh_vaatika/model/listing/listing_body.dart' as lb;

class EditTradeItemPage extends StatefulWidget {
  @override
  _EditTradeItemPageState createState() => _EditTradeItemPageState();
}

class _EditTradeItemPageState extends State<EditTradeItemPage> {
  Datum datum;
  EditListingProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<EditListingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.brown),
        backgroundColor: Colors.white,
        title: Text(
          provider.editable == null ? 'New Listing' : 'Edit Listing',
          style: TextStyle(fontSize: 16, color: Colors.brown),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.resolveWith(
                (states) => Size(MediaQuery.of(context).size.width, 48)),
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => Colors.green)),
        child:
            Text(provider.editable == null ? 'Create Listing' : 'Edit Listing'),
        onPressed: () {
          updateListing();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setImage(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      child: provider.editable != null
                          ? Image.memory(
                              base64Decode(provider.editable.image),
                            )
                          : Container(),
                      height: 300,
                      width: MediaQuery.of(context).size.width,
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
                      controller: provider.plantNameController,
                      decoration: InputDecoration(
                          labelText: 'Plant Name', border: InputBorder.none),
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
                      controller: provider.descriptionController,
                      decoration: InputDecoration(
                          labelText: 'Description  ', border: InputBorder.none),
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
                          controller: provider.ownedSinceController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              labelText: 'Owned Since (MM/YY)',
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
                          controller: provider.quantityController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              labelText: 'Quantity', border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                  provider.category != null
                      ? Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<CategoryList>(
                            hint: Text(provider.catx.name),
                            isExpanded: true,
                            items: provider.category.categoryList
                                .map((CategoryList value) {
                              return DropdownMenuItem<CategoryList>(
                                value: value,
                                child: Text(value.name),
                              );
                            }).toList(),
                            onChanged: (_) {
                              provider.updateCatx(_);
                            },
                          ),
                        )
                      : Container(),
                  Container(
                    padding: EdgeInsets.all(4),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: provider.lookinForController,
                      decoration: InputDecoration(
                          labelText: 'Looking For  ', border: InputBorder.none),
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  PickedFile pickedFile;

  setImage(context) {
    showDialog(
        context: context,
        builder: (c) => AlertDialog(
              title: Text('Select Plant Image'),
              content: Text('Please select an option'),
              actions: [
                TextButton(
                  onPressed: () {
                    ImagePicker()
                        .getImage(source: ImageSource.gallery)
                        .then((value) {
                      setState(() {
                        pickedFile = value;
                        Navigator.pop(context);
                      });
                    });
                  },
                  child: Text('Gallery'),
                ),
                TextButton(
                  onPressed: () {
                    ImagePicker()
                        .getImage(source: ImageSource.camera)
                        .then((value) {
                      setState(() {
                        pickedFile = value;
                        Navigator.pop(context);
                      });
                    });
                  },
                  child: Text('Camera'),
                ),
              ],
            ),
        useRootNavigator: true,
        barrierDismissible: false);
  }

  updateListing() async {
    lb.Datum datum = lb.Datum(
      gardenId: provider.editable.gardenId,
      quantity: int.parse(
        provider.quantityController.text.toString().trim(),
      ),
    );
    var body = lb.ListingsBody(
        data: [datum], lookingFor: provider.lookinForController.text.trim());
    ListingsService.updateListingItem(context, body, provider.editable.id)
        .then((response) {
      provider.updateEditable(null);
      Navigator.pop(context);
    });
  }
}
