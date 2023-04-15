import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toponymy/src/navigation/model/app_state_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return const MaterialPage(
        //TODO key and name
        child: SplashScreen());
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildBrandSplash(),
      ),
    );
  }

  Widget _buildBrandSplash() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Image(
          image: AssetImage("assets/images/logo/Toponymy.png"),
        ),
        SizedBox(
          height: 18,
        ),
        CircularProgressIndicator(
          color: Color(0xFF503E9D),
        )
        //Text("Initializing..."),
      ],
    );
  }
}
