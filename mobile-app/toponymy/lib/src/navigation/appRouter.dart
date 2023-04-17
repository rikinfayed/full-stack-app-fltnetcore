import 'package:flutter/material.dart';
import 'package:toponymy/src/home/home.dart';
import 'package:toponymy/src/place/screen/add_place_screen.dart';
import './model/model.dart';
import './screen/screen.dart';


class AppRouter extends RouterDelegate with PopNavigatorRouterDelegateMixin, ChangeNotifier{
  final AppStateManager _appStateManager;
  final PlaceStateManager _placeStateManager;

  AppRouter(this._appStateManager, this._placeStateManager) :navigatorKey = GlobalKey<NavigatorState>() {
    _appStateManager.addListener(notifyListeners);
    _placeStateManager.addListener(notifyListeners);
  }
  
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _handlePopPage,
      pages: [
        //start::logic navigation
        if(!_appStateManager.isInitialized) SplashScreen.page(),
        if(_appStateManager.isInitialized) HomeScreen.page(_appStateManager.selectedTab),
        if(_placeStateManager.isCreating) AddPlaceScreen.page()
        //add place
        //rif(true) AddPlaceScreen.page()
        //end::logic navigation
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result){
    if(!route.didPop(result)) {
      return false;
    }
    //start::logic Popop here
    if (route.settings.name == "addplace") {
      _placeStateManager.AddPlaceCancel();
    }
    //end::login Popup here
    return true;
  }
  
  // @override
  // Future<bool> popRoute() {
  //   // TODO: implement popRoute
  //   throw UnimplementedError();
  // }
  


  final GlobalKey<NavigatorState> navigatorKey;
  
  @override
  Future<void> setNewRoutePath(configuration) async{
    return null;
  }
}