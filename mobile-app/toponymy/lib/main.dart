import 'package:flutter/material.dart';
import 'package:toponymy/src/navigation/model/app_state_manager.dart';
import './src/navigation/navigator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AppStateManager appStateManager = AppStateManager();
  runApp(MyApp(appStateManager: appStateManager));
}

class MyApp extends StatefulWidget {
  final AppStateManager appStateManager;

  const MyApp({required this.appStateManager, Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(widget.appStateManager);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Router(routerDelegate: _appRouter),
    );
  }
}
