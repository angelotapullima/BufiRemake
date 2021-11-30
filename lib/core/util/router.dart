import 'package:bufi_remake/main.dart';
import 'package:bufi_remake/features/login/presentation/page/login.dart';
import 'package:bufi_remake/features/splash/presentation/pages/splash.dart';
import 'package:flutter/material.dart'; 
import 'constants.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => MyHomePage());
        case SPLASH_ROUTE:
        return MaterialPageRoute(builder: (_) => Splash());
       
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
