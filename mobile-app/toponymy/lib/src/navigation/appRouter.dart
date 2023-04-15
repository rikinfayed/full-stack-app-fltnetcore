import 'package:flutter/material.dart';
import 'package:toponymy/src/home/home.dart';
import './model/model.dart';
import './screen/screen.dart';


class AppRouter extends RouterDelegate with ChangeNotifier{
  final AppStateManager _appStateManager;

  AppRouter(this._appStateManager) {
    _appStateManager.addListener(notifyListeners);
  }
  
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _handlePopPage,
      pages: [
        //start::logic navigation
        if(!_appStateManager.isInitialized) SplashScreen.page(),
        if(_appStateManager.isInitialized) HomeScreen.page(_appStateManager.selectedTab)
        //end::logic navigation
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result){
    if(!route.didPop(result)) {
      return false;
    }
    //start::logic Popop here

    //end::login Popup here
    return true;
  }
  
  @override
  Future<bool> popRoute() {
    // TODO: implement popRoute
    throw UnimplementedError();
  }
  
  @override
  Future<void> setNewRoutePath(configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }

}