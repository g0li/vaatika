import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vrksh_vaatika/model/category.dart';
import 'package:vrksh_vaatika/model/garden.dart';
import 'package:vrksh_vaatika/services/garden_services.dart';

class PlantDetailProvider extends ChangeNotifier {
  Category category;
  CategoryList catx;
  TextEditingController plantNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ownedSinceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  Datum datum;
  bool absorb = true;
  PlantDetailProvider(mContext, datum) {
    this.datum = datum;

    GardenService.getCategory(mContext).then((cat) {
      category = cat;
      try {
        catx = category.categoryList.first;
      } catch (e) {
        catx = CategoryList(
            createdAt: DateTime.now(),
            id: 0,
            name: '',
            updatedAt: DateTime.now());
      }
      if (datum != null) {
        plantNameController = TextEditingController(text: this.datum.plantName);
        descriptionController =
            TextEditingController(text: this.datum.description);
        ownedSinceController =
            TextEditingController(text: this.datum.ownedSince);
        quantityController =
            TextEditingController(text: this.datum.quantity.toString());
        catx = category.categoryList
            .firstWhere((element) => element.id == this.datum.categoryId);
        absorb = true;
      } else
        absorb = false;
      notifyListeners();
    });
  }
  updateCatx(c) {
    catx = c;
    notifyListeners();
  }

  void setDate(DateTime val) {
    ownedSinceController.text = DateFormat.yMMMEd().format(val).toString();
    notifyListeners();
  }
}
