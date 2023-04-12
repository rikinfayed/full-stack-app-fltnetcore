import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext) {
    return Scaffold(body: Center(child:Text("Initializing...")),);
  }
}