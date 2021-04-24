import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/model/category.dart';
import 'package:vrksh_vaatika/services/garden_services.dart';

class PlantDetailProvider extends ChangeNotifier {
  Category category;
  CategoryList catx;
  TextEditingController plantNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ownedSinceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  PlantDetailProvider(mContext) {
    GardenService.getCategory(mContext).then((cat) {
      category = cat;
      catx = category.categoryList.first;
      notifyListeners();
    });
  }
  updateCatx(c) {
    catx = c;
    notifyListeners();
  }
}
