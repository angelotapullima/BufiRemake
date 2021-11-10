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
        title: 'Bufi',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage (),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key,  }) : super(key: key); 

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
            setState(
              () {
                itemSeleccionado = item;
                ZoomDrawer.of(context)!.close();
              },
            );
          },
        ),
      ),
      mainScreen: obtenerPage(),
    );
  }

  Widget obtenerPage() {
    switch (itemSeleccionado) {
      case MenuItems.card:
        return TarjetaPage();
      case MenuItems.home:
        return HomePage();
      default:
        return HomePage();
    }
  }
}
