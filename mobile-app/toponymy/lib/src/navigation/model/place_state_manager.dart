import 'package:flutter/material.dart';

class PlaceStateManager extends ChangeNotifier{
  bool _isCreating = false;

  bool get isCreating => _isCreating;

  void AddPlace() async {   
      _isCreating = true;
      notifyListeners();
  }

  void AddPlaceCancel() async {   
      _isCreating = false;
      notifyListeners();
  }
}