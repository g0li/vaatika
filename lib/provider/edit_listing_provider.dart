import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/model/category.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/services/garden_services.dart';

class EditListingProvider extends ChangeNotifier {
  Category category;
  CategoryList catx;
  TextEditingController plantNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ownedSinceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController lookinForController = TextEditingController();
  Datum editable;
  EditListingProvider(mContext, Datum data) {
    editable = data;
    GardenService.getCategory(mContext).then((cat) {
      category = cat;
      catx = category.categoryList.first;
      if (editable != null) {
        plantNameController =
            TextEditingController(text: this.editable.plantName);
        descriptionController =
            TextEditingController(text: this.editable.description);
        ownedSinceController =
            TextEditingController(text: this.editable.ownedSince);
        lookinForController =
            TextEditingController(text: this.editable.lookingFor);
        quantityController =
            TextEditingController(text: this.editable.quantity.toString());
        catx = category.categoryList
            .firstWhere((element) => element.id == this.editable.categoryId);
      }
      notifyListeners();
    });
  }

  updateCatx(c) {
    catx = c;
    notifyListeners();
  }

  void updateEditable(param0) {
    editable = param0;
    notifyListeners();
  }
}
