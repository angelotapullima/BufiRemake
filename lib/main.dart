
import 'package:bufi_remake/src/models/menu_items.dart';
import 'package:bufi_remake/src/pages/home_page.dart';
import 'package:bufi_remake/src/pages/menu_page.dart';
import 'package:bufi_remake/src/pages/tarjeta_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MenuItem itemSeleccionado = MenuItems.card;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 60,
      angle: -10,
      slideWidth: MediaQuery.of(context).size.width * 0.8,
      showShadow: true,
      style: DrawerStyle.Style1,
      backgroundColor: Colors.blueAccent,
      menuScreen: Builder(
          builder: (context) => MenuPage(
              itemSeleccionado: itemSeleccionado,
              onSelectItem: (item) {
                setState(() {
                  itemSeleccionado = item;
                  ZoomDrawer.of(context).close();
                });
              })),
      mainScreen: obtenerPage(),
    );
  }

  Widget obtenerPage() {
    switch (itemSeleccionado) {
      case MenuItems.card:
        return TarjetaPage();
      case MenuItems.card:
        return HomePage();
      default:
        return HomePage();
    }
  }
}
