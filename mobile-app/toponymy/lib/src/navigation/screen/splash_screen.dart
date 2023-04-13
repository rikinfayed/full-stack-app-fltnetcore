import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toponymy/src/navigation/model/app_state_manager.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return const MaterialPage(
      //TODO key and name
      child: SplashScreen()
    );
  }
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializedApp();
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(body: Center(child:Text("Initializing...")),);
  }
}