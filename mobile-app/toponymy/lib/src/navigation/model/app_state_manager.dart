import 'package:flutter/material.dart';
import 'package:toponymy/src/navigation/model/model.dart';

class AppStateManager extends ChangeNotifier{
  /**
   * Initialize 
   */
  bool _initialized = false;

  bool get isInitialized => _initialized;

  void initializedApp() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  /**
  * Tab
  */
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  void goToTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void gotExplore() {
    _selectedTab = AppTab.explore;
    notifyListeners();
  }

  void gotSaved() {
    _selectedTab = AppTab.saved;
    notifyListeners();
  }
}