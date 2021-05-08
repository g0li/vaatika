import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/model/category.dart';
import 'package:vrksh_vaatika/model/garden.dart';

import 'package:vrksh_vaatika/services/garden_services.dart';

class NewListingProvider extends ChangeNotifier {
  Category category;
  CategoryList catx;
  TextEditingController plantNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ownedSinceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController lookinForController = TextEditingController();
  Datum datum;
  NewListingProvider(mContext) {
    GardenService.getCategory(mContext).then((cat) {
      category = cat;
      catx = category.categoryList.first;
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
      }
      notifyListeners();
    });
  }
  updateCatx(c) {
    catx = c;
    notifyListeners();
  }

  updateDatum(d) {
    datum = d;
    if (datum != null) {
      plantNameController = TextEditingController(text: this.datum.plantName);
      descriptionController =
          TextEditingController(text: this.datum.description);
      ownedSinceController = TextEditingController(text: this.datum.ownedSince);
      quantityController =
          TextEditingController(text: this.datum.quantity.toString());
      catx = category.categoryList
          .firstWhere((element) => element.id == this.datum.categoryId);
    } else {
      plantNameController = TextEditingController();
      descriptionController = TextEditingController();
      ownedSinceController = TextEditingController();
      quantityController = TextEditingController();
      lookinForController = TextEditingController();
    }
    notifyListeners();
  }
}
