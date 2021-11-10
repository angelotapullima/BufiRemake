import 'package:bufi_remake/main.dart';
import 'package:bufi_remake/screens/login/presentation/page/login.dart';
import 'package:flutter/material.dart'; 
import 'constants.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => MyHomePage());
       
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
