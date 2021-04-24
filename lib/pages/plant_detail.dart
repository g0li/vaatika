import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vrksh_vaatika/model/category.dart';
import 'package:vrksh_vaatika/model/garden.dart';
import 'package:vrksh_vaatika/model/garden_item.dart';
import 'package:vrksh_vaatika/provider/plant_detail_provider.dart';
import 'package:vrksh_vaatika/services/garden_services.dart';

class PlantDetailPage extends StatefulWidget {
  @override
  _PlantDetailPageState createState() => _PlantDetailPageState();
}

class _PlantDetailPageState extends State<PlantDetailPage> {
  PlantDetailProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<PlantDetailProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: Colors.brown),
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
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.green)),
            child: Text('Save'),
            onPressed: () {
              postPlant();
            },
          ),
          body: SingleChildScrollView(
            child: Form(
                child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setImage(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: (pickedFile != null)
                        ? Image.file(File(pickedFile.path), fit: BoxFit.fill)
                        : Container(
                            padding: EdgeInsets.all(4),
                            color: Colors.green,
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
                    controller: provider.descriptionController,
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
                        controller: provider.ownedSinceController,
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
                        controller: provider.quantityController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            hintText: 'Quantity', border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
                provider.category != null
                    ? Container(
                        color: Colors.white,
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
                    : Container()
              ],
            )),
          )),
    );
  }

  postPlant() async {
    var bytes = await pickedFile.readAsBytes();
    final encoded = base64.encode(bytes);

    GardenItem item = GardenItem(
        categoryId: provider.catx.id.toString(),
        description: provider.descriptionController.text.trim(),
        image: encoded,
        ownedSince: provider.ownedSinceController.text.trim(),
        plantName: provider.plantNameController.text.trim(),
        quantity: provider.quantityController.text.trim());
    GardenService.postPlantItem(context, item).then((value) {
      ScaffoldMessenger.maybeOf(context)
          .showSnackBar(SnackBar(
              content: Text(
            value['message'],
          )))
          .closed
          .then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
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
}
