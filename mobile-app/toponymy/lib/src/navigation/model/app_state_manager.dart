import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier{
  bool _initialized = false;

  bool get isInitialized => _initialized;

  void initializedApp() async {
    Future.delayed(Duration(microseconds: 3000), () {
      _initialized = true;
      notifyListeners();
    });
  }
}