import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vrksh_vaatika/model/category.dart';
import 'package:vrksh_vaatika/model/garden.dart';
import 'package:vrksh_vaatika/model/listing/listing_body.dart' as lb;
import 'package:vrksh_vaatika/model/listing/listings.dart' as l;
import 'package:vrksh_vaatika/pages/garden.dart';
import 'package:vrksh_vaatika/provider/new_listing_provider.dart';
import 'package:vrksh_vaatika/provider/plant_detail_provider.dart';
import 'package:vrksh_vaatika/services/listings_services.dart';

class NewTradeItemPage extends StatefulWidget {
  final l.Datum editable;

  const NewTradeItemPage({Key key, this.editable}) : super(key: key);
  @override
  _NewTradeItemPageState createState() => _NewTradeItemPageState();
}

class _NewTradeItemPageState extends State<NewTradeItemPage> {
  NewListingProvider provider;

  Datum datum;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<NewListingProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        provider.updateDatum(null);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.brown),
          backgroundColor: Colors.white,
          title: Text(
            widget.editable == null ? 'New Listing' : 'Edit Listing',
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
              Text(widget.editable == null ? 'Create Listing' : 'Edit Listing'),
          onPressed: () {
            createListing();
          },
        ),
        body: isAPICalled == true
            ? shimmie()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: widget.editable == null,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButtonTheme(
                          data: ElevatedButtonThemeData(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Colors.white),
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Colors.green),
                                  minimumSize:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Size(
                                              MediaQuery.of(context).size.width,
                                              48)))),
                          child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                        child: GardenPage(
                                          getPlant: true,
                                        ),
                                        create: (c) => NewListingProvider(
                                          c,
                                        ),
                                      ),
                                    )).then((value) {
                                  provider.updateDatum(value);
                                });
                              },
                              icon: Icon(Icons.grass),
                              label: Text('Select From Garden')),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.editable == null,
                      child: Padding(
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
                    ),
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
                              child: widget.editable != null
                                  ? Image.memory(
                                      base64Decode(widget.editable.image),
                                      fit: BoxFit.fill)
                                  : provider.datum != null
                                      ? Image.memory(
                                          base64Decode(provider.datum.image),
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        )
                                      : (pickedFile != null)
                                          ? Image.file(File(pickedFile.path),
                                              fit: BoxFit.fill)
                                          : Container(
                                              padding: EdgeInsets.all(4),
                                              child: Icon(
                                                Icons.camera_alt,
                                                size: 100,
                                              ),
                                              height: 300,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
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
                                  labelText: 'Plant Name',
                                  border: InputBorder.none),
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
                                  labelText: 'Description  ',
                                  border: InputBorder.none),
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
                                      labelText: 'Quantity',
                                      border: InputBorder.none),
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
                                  labelText: 'Looking For  ',
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  PickedFile pickedFile;
  shimmie() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100],
      highlightColor: Colors.grey[300],
      child: Column(
        children: [
          Visibility(
            visible: widget.editable == null,
            child: Padding(
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
                    onPressed: null,
                    icon: Icon(Icons.grass),
                    label: Text('Select From Garden')),
              ),
            ),
          ),
          Visibility(
            visible: widget.editable == null,
            child: Padding(
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
          ),
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
                    child: widget.editable != null
                        ? Image.memory(base64Decode(widget.editable.image),
                            fit: BoxFit.fill)
                        : provider.datum != null
                            ? Image.memory(
                                base64Decode(provider.datum.image),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              )
                            : (pickedFile != null)
                                ? Image.file(File(pickedFile.path),
                                    fit: BoxFit.fill)
                                : Container(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 100,
                                    ),
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                  ),
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
    );
  }

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

  bool isAPICalled = false;
  createListing() {
    lb.Datum datum = lb.Datum(
        gardenId: provider.datum.id,
        quantity:
            int.parse(provider.quantityController.text.toString().trim()));
    lb.ListingsBody lBody = lb.ListingsBody(
        data: [datum], lookingFor: provider.lookinForController.text.trim());
    isAPICalled = true;
    ListingsService.createListing(context, lBody).then((response) {
      isAPICalled = false;
      provider.updateDatum(null);
      print(response.message);
      Navigator.pop(context);
    });
  }
}
