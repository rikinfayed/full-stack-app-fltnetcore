import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier{
  bool _initialized = false;

  bool get isInitialized => _initialized;

  void initializedApp() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {
      _initialized = true;
      notifyListeners();
    });
  }
}