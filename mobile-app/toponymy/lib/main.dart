import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:toponymy/src/maps/maps.dart';
import 'package:toponymy/src/navigation/navigation.dart';
import 'package:toponymy/src/theme/toponymy_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AppStateManager appStateManager = AppStateManager();
  final PlaceStateManager placeStateManager = PlaceStateManager();
  runApp(MyApp(appStateManager: appStateManager, placeStateManager : placeStateManager));
}

class MyApp extends StatefulWidget {
  final AppStateManager appStateManager;
  final PlaceStateManager placeStateManager;

  const MyApp({required this.appStateManager, required this.placeStateManager, Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(widget.appStateManager, widget.placeStateManager);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData toponymyTheme = ToponymyTheme.light();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => widget.appStateManager),
        ChangeNotifierProvider(create: (context) => widget.placeStateManager),
        BlocProvider(create: (context) => PlacesBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: toponymyTheme,
        home: Router(routerDelegate: _appRouter,backButtonDispatcher: RootBackButtonDispatcher()),
      ),
    );
  }
}
