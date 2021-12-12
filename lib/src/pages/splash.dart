import 'package:bufi_remake/core/sharedpreferences/storage_manager.dart';
import 'package:bufi_remake/core/util/constants.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      String? token = await StorageManager.readData('token');
      if (token == null || token.isEmpty) {
        Navigator.pushNamed(context, LOGIN_ROUTE);
      } else {
        Navigator.pushNamed(context, HOME_ROUTE);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
